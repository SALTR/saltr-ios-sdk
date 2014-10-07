/*
 * @file SLTMatchingLevelParser.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTMatchingLevelParser.h"
#import "SLTMatchingBoard.h"
#import "SLTCells.h"
#import "SLTMatchingBoardLayer.h"
#import "SLTCell.h"
#import "SLTAsset.h"
#import "SLTAssetInstance.h"
#import "SLTChunkAssetRule.h"
#import "SLTChunk.h"

@implementation SLTMatchingLevelParser

-(id) initUniqueInstance
{
    self = [super init];
    return self;
}

+(instancetype) sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedMatchingLevelParser = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedMatchingLevelParser = [[super alloc] initUniqueInstance];
    });
    
    // returns the same object each time
    return _sharedMatchingLevelParser;
}

-(NSMutableDictionary*) parseLevelContentFromBoardNodes:(NSDictionary*)boardNodes andAssetMap:(NSDictionary*)assetMap
{
    NSMutableDictionary* boards = [NSMutableDictionary new];
    for (NSString* boardId in boardNodes) {
        NSDictionary* boardNode = [boardNodes objectForKey:boardId];
        [boards setObject:[self parseLevelBoardFromBoardNode:boardNode andAssetMap:assetMap] forKey:boardId];
    }
    return boards;
}

#pragma mark private functions

-(SLTMatchingBoard*) parseLevelBoardFromBoardNode:(NSDictionary*)theBoardNode andAssetMap:(NSDictionary*)theAssetMap
{
    NSDictionary* boardProperties = [theBoardNode objectForKey:@"properties"];
    
    SLTCells* cells = [[SLTCells alloc] initWithWidth:[[theBoardNode objectForKey:@"cols"] integerValue] andHeight:[[theBoardNode objectForKey:@"rows"] integerValue]];
    [self initializeCells:cells andBoardNode:theBoardNode];
    
    NSMutableArray* layers = [[NSMutableArray alloc] init];
    NSArray* layerNodes = [theBoardNode objectForKey:@"layers"];
    NSInteger index = 0;
    for (NSDictionary* layerNode in layerNodes) {
        SLTMatchingBoardLayer* layer = [self parseLayer:layerNode andIndex:index andCells:cells andAssetMap:theAssetMap];
        [layers addObject:layer];
        ++index;
    }
    return [[SLTMatchingBoard alloc] initWithCells:cells layers:layers andProperties:boardProperties];
}

-(void) initializeCells:(SLTCells*)cells andBoardNode:(NSDictionary*)boardNode
{
    NSArray* blockedCells = [boardNode objectForKey:@"blockedCells"];
    NSArray* cellProperties = [boardNode objectForKey:@"cellProperties"];
    NSInteger cols = cells.width;
    NSInteger rows = cells.height;
    
    for (NSInteger i = 0; i < cols; ++i) {
        for (NSInteger j = 0; j < rows; ++j) {
            SLTCell* cell = [[SLTCell alloc] initWithCol:i andRow:j];
            [cells insertCell:cell atCol:i andRow:j];
        }
    }
    
    //assigning cell properties
    for (NSDictionary* property in cellProperties) {
        NSArray* coords = [property objectForKey:@"coords"];
        SLTCell* cell2 = [cells retrieveCellAtCol:[[coords objectAtIndex:0] integerValue] andRow:[[coords objectAtIndex:1] integerValue]];
        if (nil != cell2) {
            cell2.properties = [property objectForKey:@"value"];
        }
    }
    
    //blocking cells
    for (NSArray* blockedCell in blockedCells) {
        SLTCell* cell3 = [cells retrieveCellAtCol:[[blockedCell objectAtIndex:0] integerValue] andRow:[[blockedCell objectAtIndex:1] integerValue]];
        if (nil != cell3) {
            cell3.isBlocked = YES;
        }
    }
}

-(SLTMatchingBoardLayer*) parseLayer:(NSDictionary*)layerNode andIndex:(NSInteger)index andCells:(SLTCells*)cells andAssetMap:(NSDictionary*)assetMap
{
    //temporarily checking for 2 names until "layerId" is removed!
    NSString* token = [layerNode objectForKey:@"token"];
    if (nil == token) {
        token = [layerNode objectForKey:@"layerId"];
    }
    SLTMatchingBoardLayer* layer = [[SLTMatchingBoardLayer alloc] initWithToken:token andLayerIndex:index];
    [self parseFixedAssets:layer andAssetNodes:[layerNode objectForKey:@"fixedAssets"] andCells:cells andAssetMap:assetMap];
    [self parseLayerChunks:layer andChunkNodes:[layerNode objectForKey:@"chunks"] andCells:cells andAssetMap:assetMap];
    return layer;
}

-(void) parseFixedAssets:(SLTMatchingBoardLayer*)layer andAssetNodes:(NSArray*)assetNodes andCells:(SLTCells*)cells andAssetMap:(NSDictionary*)assetMap
{
    //creating fixed asset instances and assigning them to cells where they belong
    for(NSDictionary* assetInstanceNode in assetNodes) {
        
        SLTAsset* asset = [assetMap objectForKey:[[assetInstanceNode objectForKey:@"assetId"] stringValue]];
        
        NSArray* stateIds = [assetInstanceNode objectForKey:@"states"];
        NSArray* cellPositions = [assetInstanceNode objectForKey:@"cells"];
        
        for(NSArray* position in cellPositions) {
            SLTCell* cell = [cells retrieveCellAtCol:[[position objectAtIndex:0] integerValue] andRow:[[position objectAtIndex:1] integerValue]];
            
            SLTAssetInstance* assetInstance = [[SLTAssetInstance alloc] initWithToken:asset.token states:[asset getInstanceStates:stateIds] andProperties:asset.properties];
            
            [cell setAssetInstanceByLayerId:layer.token layerIndex:layer.index andAssetInstance:assetInstance];
        }
    }
}

-(void) parseLayerChunks:(SLTMatchingBoardLayer*)layer andChunkNodes:(NSArray*)chunkNodes andCells:(SLTCells*)cells andAssetMap:(NSDictionary*)assetMap
{
    for(NSDictionary* chunkNode in chunkNodes) {
        NSArray* cellNodes = [chunkNode objectForKey:@"cells"];
        NSMutableArray* chunkCells = [[NSMutableArray alloc] init];
        for(NSArray* cellNode in cellNodes) {
            [chunkCells addObject:[cells retrieveCellAtCol:[[cellNode objectAtIndex:0] integerValue] andRow:[[cellNode objectAtIndex:1] integerValue]]];
        }
        
        NSArray* AssetNodes = [chunkNode objectForKey:@"assets"];
        NSMutableArray* chunkAssetRules = [[NSMutableArray alloc] init];
        for(NSDictionary* assetNode in AssetNodes) {
            SLTChunkAssetRule* chunkAssetRule = [[SLTChunkAssetRule alloc] initWithAssetId:[[assetNode objectForKey:@"assetId"] stringValue] distributionType:[assetNode objectForKey:@"distributionType"] distributionValue:[[assetNode objectForKey:@"distributionValue"] integerValue] andStateIds:[assetNode objectForKey:@"states"]];
            [chunkAssetRules addObject:chunkAssetRule];
        }
        
        SLTChunk* chunk = [[SLTChunk alloc] initWithLayerToken:layer.token layerIndex:layer.index chunkCells:chunkCells chunkAssetRules:chunkAssetRules andAssetMap:assetMap];
        [layer addChunk:chunk];
    }
}

@end
