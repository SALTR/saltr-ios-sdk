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
#import "SLTCell.h"
#import "SLTChunkAssetRule.h"

@interface SLTChunk() {
    //TODO: @TIGR check for weak reference;
    NSString* _layerToken;
    NSInteger _layerIndex;
    NSMutableArray* _chunkCells;
    NSMutableArray* _chunkAssetRules;
    NSDictionary* _assetMap;
    NSMutableArray* _availableCells;
}
@end

@implementation SLTChunk

- (id)initWithLayerToken:(NSString*)theLayerToken layerIndex:(NSInteger)theLayerIndex chunkCells:(NSMutableArray*)theChunkCells chunkAssetRules:(NSMutableArray*)theChunkAssetRules andAssetMap:(NSDictionary*)theAssetMap
{
    self = [super init];
    if (self) {
        _layerToken = theLayerToken;
        _layerIndex = theLayerIndex;
        _chunkCells = theChunkCells;
        _chunkAssetRules = theChunkAssetRules;
        _assetMap = theAssetMap;
    }
    return self;
}

-(NSString *)description
{
        return [NSString stringWithFormat: @"[Chunk] cells: %lu, chunkAssets: %lu", (unsigned long)[_availableCells count], (unsigned long)[_chunkAssetRules count]];
}

- (void)generateContent
{
    //resetting chunk cells, as when chunk can contain empty cells, previous generation can leave assigned values to cells
    [self resetChunkCells];
    
    //availableCells are being always overwritten here, so no need to initialize
    [_availableCells addObjectsFromArray:_chunkCells];
    
    NSMutableArray* countChunkAssetRules = [[NSMutableArray alloc] init];
    NSMutableArray* ratioChunkAssetRules = [[NSMutableArray alloc] init];
    NSMutableArray* randomChunkAssetRules = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < _chunkAssetRules.count; ++i) {
        assert([[_chunkAssetRules objectAtIndex:i] isKindOfClass:[SLTChunkAssetRule class]]);
        SLTChunkAssetRule* chunkAsset = [_chunkAssetRules objectAtIndex:i];
        assert(nil != chunkAsset);
        if ([[chunkAsset distributionType] isEqualToString:@"count"]) {
            [countChunkAssetRules addObject:chunkAsset];
        } else if([[chunkAsset distributionType] isEqualToString:@"ratio"]) {
            [ratioChunkAssetRules addObject:chunkAsset];
        } else if([[chunkAsset distributionType] isEqualToString:@"random"]) {
            [randomChunkAssetRules addObject:chunkAsset];
        }
    }
    
    if (0 < [countChunkAssetRules count]) {
        [self generateAssetInstancesByCount:countChunkAssetRules];
    }
    if (0 < [ratioChunkAssetRules count]) {
        [self generateAssetInstancesByRatio:ratioChunkAssetRules];
    }
    if (0 < [randomChunkAssetRules count]) {
        [self generateAssetInstancesRandomly:randomChunkAssetRules];
    }
    //TODO: @TIGR check this later
    //_availableCells.length = 0;
}

- (void)resetChunkCells
{
    for (SLTCell* cell in _chunkCells) {
        [cell removeAssetInstanceByLayerId:_layerToken andLayerIndex:_layerIndex];
    }
}

- (void)generateAssetInstancesByCount:(NSMutableArray*)countChunkAssetRules
{
    //TODO: @TIGR implement
}

- (void)generateAssetInstancesByRatio:(NSMutableArray*)ratioChunkAssetRules
{
    //TODO: @TIGR implement
}

- (void)generateAssetInstancesRandomly:(NSMutableArray*)randomChunkAssetRules
{
    //TODO: @TIGR implement
}


@end
