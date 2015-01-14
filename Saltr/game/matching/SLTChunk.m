/*
 * @file SLTChunk.m
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
#import "SLTAsset.h"
#import "SLTAssetInstance.h"

@interface SLTChunk() {
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
        _availableCells = [[NSMutableArray alloc] init];
        _chunkCells = theChunkCells;
        _chunkAssetRules = theChunkAssetRules;
        _assetMap = theAssetMap;
    }
    return self;
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
    [_availableCells removeAllObjects];
}

- (void)resetChunkCells
{
    for (SLTCell* cell in _chunkCells) {
        [cell removeAssetInstanceByLayerId:_layerToken andLayerIndex:_layerIndex];
    }
}

- (void)generateAssetInstancesByCount:(NSMutableArray*)countChunkAssetRules
{
    for(NSInteger i = 0; i < [countChunkAssetRules count]; ++i) {
        SLTChunkAssetRule* assetRule = [countChunkAssetRules objectAtIndex:i];
        [self generateAssetInstancesWithCount:[assetRule distributionValue] assetId:[assetRule assetId] stateIds:[assetRule stateIds]];
    }
}

- (void)generateAssetInstancesByRatio:(NSMutableArray*)ratioChunkAssetRules
{
    float ratioSum = 0;
    NSInteger len = [ratioChunkAssetRules count];
    SLTChunkAssetRule* assetRule;
    for(NSInteger i = 0; i<len; ++i) {
        assetRule = [ratioChunkAssetRules objectAtIndex:i];
        ratioSum += [assetRule distributionValue];
    }
    
    NSUInteger availableCellsNum = [_availableCells count];
    float proportion;
    int count;
    NSMutableArray* fractionAssetsUnsorted = [[NSMutableArray alloc] init];
    if(ratioSum != 0) {
        for(NSInteger j=0; j<len; ++j) {
            assetRule = [ratioChunkAssetRules objectAtIndex:j];
            proportion = (float)[assetRule distributionValue] / (float)ratioSum * (float)availableCellsNum;
            count = (int)proportion; //assigning number to int to floor the value;
            NSMutableDictionary* fractionAsset = [[NSMutableDictionary alloc] init];
            [fractionAsset setValue:[NSNumber numberWithDouble:proportion- count] forKey:@"fraction"];
            [fractionAsset setValue:assetRule forKey:@"assetRule"];
            [fractionAssetsUnsorted addObject:fractionAsset];
            
            [self generateAssetInstancesWithCount:count assetId:[assetRule assetId] stateIds:[assetRule stateIds]];
        }
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fraction"
                                                     ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *fractionAssets;
        fractionAssets = [fractionAssetsUnsorted sortedArrayUsingDescriptors:sortDescriptors];

        availableCellsNum = [_availableCells count];
        
        for(NSInteger k=0; k<availableCellsNum; ++k) {
            [self generateAssetInstancesWithCount:1 assetId:[[[fractionAssets objectAtIndex:k] objectForKey:@"assetRule"] assetId] stateIds:[[[fractionAssets objectAtIndex:k] objectForKey:@"assetRule"] stateIds]];
        }
    }
}

- (void)generateAssetInstancesRandomly:(NSMutableArray*)randomChunkAssetRules
{
    NSUInteger len = [randomChunkAssetRules count];
    NSUInteger availableCellsNum = [_availableCells count];
    if(len > 0) {
        NSNumber* assetConcentration = availableCellsNum > len ? [NSNumber numberWithDouble:availableCellsNum/len] : [NSNumber numberWithInt:1];
        NSUInteger minAssetCount = [assetConcentration doubleValue] <= 2 ? 1 : [assetConcentration doubleValue] - 2;
        NSUInteger maxAssetCount = [assetConcentration doubleValue] == 1 ? 1 : [assetConcentration doubleValue] + 2;
        NSInteger lastChunkAssetIndex = len - 1;
        
        SLTChunkAssetRule* chunkAssetRule;
        NSUInteger count;
        for(NSInteger i = 0; i<len && [_availableCells count] > 0; ++i) {
            chunkAssetRule = [randomChunkAssetRules objectAtIndex:i];
            count = i == lastChunkAssetIndex ? [_availableCells count] : (NSUInteger)[self randomWithinMin:[NSNumber numberWithInteger:minAssetCount] max:[NSNumber numberWithInteger:maxAssetCount] isFloat:NO];
            
            [self generateAssetInstancesWithCount:count assetId:[chunkAssetRule assetId] stateIds:[chunkAssetRule stateIds]];
        }
    }
}

-(void) generateAssetInstancesWithCount:(NSUInteger)theCount assetId:(NSString*)theAssetId stateIds:(NSArray*)theStateIds
{
    SLTAsset* asset = [_assetMap objectForKey:theAssetId];
    for(NSInteger i = 0; i<theCount; ++i) {
        NSUInteger randCellIndex = arc4random_uniform([_availableCells count]);
        SLTCell* randCell = [_availableCells objectAtIndex:randCellIndex];
        SLTAssetInstance* assetInstance = [[SLTAssetInstance alloc] initWithToken:[asset token] states:[asset getInstanceStates:theStateIds] andProperties:[asset properties]];
        [randCell setAssetInstanceByLayerId:_layerToken layerIndex:_layerIndex andAssetInstance:assetInstance];
        
        [_availableCells removeObjectAtIndex:randCellIndex];
        if (0 == [_availableCells count]) {
            return;
        }
    }
}

-(NSNumber*) randomWithinMin:(NSNumber*)theMin max:(NSNumber*)theMax isFloat:(BOOL)theIsFloat
{
    double value = arc4random_uniform(1 + [theMax doubleValue] - [theMin doubleValue]) + [theMin doubleValue];
    if (theIsFloat) {
        return [NSNumber numberWithDouble:value];
    } else {
        return [NSNumber numberWithInteger:value];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat: @"[Chunk] cells: %lu, chunkAssets: %lu", (unsigned long)[_availableCells count], (unsigned long)[_chunkAssetRules count]];
}

@end
