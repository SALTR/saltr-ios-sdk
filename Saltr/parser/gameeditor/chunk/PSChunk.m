/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSChunk.h"
#import "PSCell.h"
#import "PSAssetInChunk.h"
#import "PSLevelStructure.h"
#import "PSBoardData.h"
#import "PSLevelBoard_Private.h"
#import "PSSimpleAssetTemplate.h"
#import "PSSimpleAsset.h"
#import "PSVector2D.h"

@interface PSChunk() {
    NSDictionary* _boardAssetMap;
    NSDictionary* _boardStateMap;
    NSMutableArray* _chunkAssets;
    NSMutableArray* _cells;

}
@end

@implementation PSChunk

@synthesize ownerLevelBoard = _ownerLevelBoard;
@synthesize chunkId = _chunkId;

- (id)initWithChunkId:(NSString*)theChunkId andOwnerLevelBoard:(PSLevelBoard *)theOwnerLevelBoard
{
    self = [super init];
    if (self) {
        assert(nil != theChunkId);
        assert(nil != theOwnerLevelBoard);
        _chunkId = theChunkId;
        _ownerLevelBoard = theOwnerLevelBoard;
        _cells = [[NSMutableArray alloc] init];
        _chunkAssets = [[NSMutableArray alloc] init];
        _boardAssetMap = theOwnerLevelBoard.ownerLevel.boardData.assetMap;
        _boardStateMap = theOwnerLevelBoard.ownerLevel.boardData.stateMap;
    }
    return self;
}

- (void) addCell:(PSCell*)theCell
{
    if (!theCell) {
        return;
    }
    [_cells addObject:theCell];

}

- (void) addChunkAsset:(PSAssetInChunk*)theChunkAsset
{
    if (!theChunkAsset) {
        return;
    }
    [_chunkAssets addObject:theChunkAsset];
}

- (void)generateAssetWithCount:(NSUInteger)count assetId:(NSString*)assetId andStateId:(NSString*)stateId
{
    PSSimpleAssetTemplate* simpleAssetTemplate = [_boardAssetMap objectForKey:assetId];
    assert(nil != simpleAssetTemplate);
    NSString* state = [_boardStateMap objectForKey:stateId];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger randCellIndex = (arc4random() % _cells.count);
        PSCell* randCell = _cells[randCellIndex];
        PSSimpleAsset* asset = [[PSSimpleAsset alloc] initWithState:state cell:randCell type:simpleAssetTemplate.type andKeys:simpleAssetTemplate.keys];
        [_ownerLevelBoard.boardVector addObject:asset atRow:randCell.x andColumn:randCell.y];
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
        PSAssetInChunk* chunkAsset = weakChunkAssets[i];
        assert(nil != chunkAsset);
        NSUInteger count = (lastChunkAssetIndex ? _cells.count : [self randomIntWithinMin:minAssetCount andMax:maxAssetCount]);
        [self generateAssetWithCount:count assetId:chunkAsset.assetId andStateId:chunkAsset.stateId];
    }
}

- (void)generate
{
    NSMutableArray* weakChunkAssets = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [_chunkAssets count]; ++i) {
        PSAssetInChunk* chunkAsset = [_chunkAssets objectAtIndex:i];
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
    return [NSString stringWithFormat: @"Chunk : [chunkId : %@], [cells : %@], [chunkAssets: %@], [ownerLevel : %@]", self.chunkId, _cells, _chunkAssets, self.ownerLevelBoard];
}

@end
