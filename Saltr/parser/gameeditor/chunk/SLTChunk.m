/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTChunk.h"
#import "SLTCell_Private.h"
#import "SLTChunkAssetInfo.h"
#import "SLTLevelSettings.h"
#import "SLTAsset.h"
#import "SLTAssetInstance.h"

@interface SLTChunk() {
    NSDictionary* _boardAssetMap;
    NSDictionary* _boardStateMap;
    NSMutableArray* _chunkAssets;
    NSMutableArray* _cells;

}
@end

@implementation SLTChunk

@synthesize chunkId = _chunkId;

- (id)initWithChunkId:(NSString*)theChunkId andBoardData:(SLTLevelSettings *)theBoardData
{
    self = [super init];
    if (self) {
        assert(nil != theChunkId);
        assert(nil != theBoardData);
        _chunkId = theChunkId;
        _cells = [[NSMutableArray alloc] init];
        _chunkAssets = [[NSMutableArray alloc] init];
        _boardAssetMap = theBoardData.assetMap;
        _boardStateMap = theBoardData.stateMap;
    }
    return self;
}

- (void) addCell:(SLTCell*)theCell
{
    if (!theCell) {
        return;
    }
    [_cells addObject:theCell];

}

- (void) addChunkAsset:(SLTChunkAssetInfo*)theChunkAsset
{
    if (!theChunkAsset) {
        return;
    }
    [_chunkAssets addObject:theChunkAsset];
}

- (void)generateAssetWithCount:(NSUInteger)count assetId:(NSString*)assetId andStateId:(NSString*)stateId
{
    SLTAsset* assetTemplate = [_boardAssetMap objectForKey:assetId];
    assert(nil != assetTemplate);
    NSString* state = [_boardStateMap objectForKey:stateId];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger randCellIndex = (arc4random() % _cells.count);
        SLTCell* randCell = _cells[randCellIndex];
        SLTAssetInstance* asset = [[SLTAssetInstance alloc] initWithState:state type:assetTemplate.type andKeys:assetTemplate.keys];
        randCell.assetInstance = asset;
        [_cells removeObjectAtIndex:randCellIndex];
        if (0 == _cells.count) {
            return;
        }
    }
}

- (NSUInteger)randomIntWithinMin:(NSUInteger)min andMax:(NSUInteger)max
{
    return arc4random() % (1 + max - min) + min;
}

- (double)randomFloatWithinMin:(NSUInteger)min andMax:(NSUInteger)max
{
    return floorf(((double)arc4random() / (1 + max - min)) * 100.0f) + min;
}

- (void)generateWeakAssets:(NSMutableArray*)weakChunkAssets
{
    assert(nil != weakChunkAssets);
    if (0 == weakChunkAssets.count) {
        return;
    }
    NSUInteger assetConcentration = (_cells.count > weakChunkAssets.count) ? _cells.count / weakChunkAssets.count : 1;
    NSUInteger minAssetCount = (2 >= assetConcentration) ? 1 : assetConcentration - 2;
    NSUInteger maxAssetCount = (1 == assetConcentration) ? 1 : assetConcentration + 2;
    NSUInteger lastChunkAssetIndex = (weakChunkAssets.count - 1);
    for (NSUInteger i = 0; (i < weakChunkAssets.count) && (0 != _cells.count); ++i) {
        SLTChunkAssetInfo* chunkAsset = weakChunkAssets[i];
        assert(nil != chunkAsset);
        NSUInteger count = (lastChunkAssetIndex ? _cells.count : [self randomIntWithinMin:minAssetCount andMax:maxAssetCount]);
        [self generateAssetWithCount:count assetId:chunkAsset.assetId andStateId:chunkAsset.stateId];
    }
}

- (void)generate
{
    NSMutableArray* weakChunkAssets = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [_chunkAssets count]; ++i) {
        SLTChunkAssetInfo* chunkAsset = [_chunkAssets objectAtIndex:i];
        assert(nil != chunkAsset);
        if (0 != chunkAsset.count) {
            [self generateAssetWithCount:chunkAsset.count assetId:chunkAsset.assetId andStateId:chunkAsset.stateId];
        } else {
            [weakChunkAssets addObject:chunkAsset];
        }
    }
    if (0 < [weakChunkAssets count]) {
        [self generateWeakAssets:weakChunkAssets];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"Chunk : [chunkId : %@], [cells : %@], [chunkAssets: %@]", self.chunkId, _cells, _chunkAssets];
}

@end
