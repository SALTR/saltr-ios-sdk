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
    NSDictionary* _assetMap;
    NSDictionary* _stateMap;
    NSMutableArray* _chunkAssetInfos;
    NSMutableArray* _availableCells;
    NSMutableArray* _chunkCells;
    NSString* _chunkId;

}
@end

@implementation SLTChunk

- (id)initWithChunkCells:(NSMutableArray*)chunkCells andChunkAssetInfos:(NSMutableArray*)chunkAssetInfos andLevelSettings:(SLTLevelSettings *)theLevelSettings
{
    self = [super init];
    if (self) {
        assert(chunkCells);
        assert(chunkAssetInfos);
        assert(theLevelSettings);
        _availableCells = [[NSMutableArray alloc] init];
        _chunkAssetInfos = chunkAssetInfos;
        _chunkCells = chunkCells;
        _assetMap = theLevelSettings.assetMap;
        _stateMap = theLevelSettings.stateMap;
    }
    return self;
}

- (void)generateAssetInstancesWithCount:(NSUInteger)count assetId:(NSString*)assetId andStateId:(NSString*)stateId
{
    SLTAsset* asset = [_assetMap objectForKey:assetId];
    NSAssert(nil != asset, @"The asset with assetID=%@ does not exist in the map of assets in level settings", assetId);
    NSString* state = [_stateMap objectForKey:stateId];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger randCellIndex = (arc4random() % _availableCells.count);
        SLTCell* randCell = _availableCells[randCellIndex];
        assert([randCell isKindOfClass:[SLTCell class]]);
        randCell.assetInstance = [[SLTAssetInstance alloc] initWithState:state type:asset.type andKeys:asset.keys];
        [_availableCells removeObjectAtIndex:randCellIndex];
        if (0 == _availableCells.count) {
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

- (void)generateWeakAssetsInstanes:(NSMutableArray*)weakChunkAssetInfos
{
    assert(nil != weakChunkAssetInfos);
    if (0 == weakChunkAssetInfos.count) {
        return;
    }
    NSUInteger assetConcentration = (_availableCells.count > weakChunkAssetInfos.count) ? _availableCells.count / weakChunkAssetInfos.count : 1;
    NSUInteger minAssetCount = (2 >= assetConcentration) ? 1 : assetConcentration - 2;
    NSUInteger maxAssetCount = (1 == assetConcentration) ? 1 : assetConcentration + 2;
    NSUInteger lastChunkAssetIndex = (weakChunkAssetInfos.count - 1);
    
    for (NSUInteger i = 0; (i < weakChunkAssetInfos.count) && (0 < _availableCells.count); ++i) {
        SLTChunkAssetInfo* chunkAssetInfo = weakChunkAssetInfos[i];
        assert(nil != chunkAssetInfo);
        NSUInteger count = (lastChunkAssetIndex ? _availableCells.count : [self randomIntWithinMin:minAssetCount andMax:maxAssetCount]);
        [self generateAssetInstancesWithCount:count assetId:chunkAssetInfo.assetId andStateId:chunkAssetInfo.stateId];
    }
}

- (void)generate
{
    [_availableCells addObjectsFromArray:_chunkCells];
    NSMutableArray* weakChunkAssets = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < _chunkAssetInfos.count; ++i) {
        assert([[_chunkAssetInfos objectAtIndex:i] isKindOfClass:[SLTChunkAssetInfo class]]);
        SLTChunkAssetInfo* chunkAsset = [_chunkAssetInfos objectAtIndex:i];
        assert(nil != chunkAsset);
        if (0 != chunkAsset.count) {
            [self generateAssetInstancesWithCount:chunkAsset.count assetId:chunkAsset.assetId andStateId:chunkAsset.stateId];
        } else {
            [weakChunkAssets addObject:chunkAsset];
        }
    }
    if (0 < [weakChunkAssets count]) {
        [self generateWeakAssetsInstanes:weakChunkAssets];
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"Chunk : [cells : %@], [chunkAssets: %@]", _availableCells, _chunkAssetInfos];
}

@end
