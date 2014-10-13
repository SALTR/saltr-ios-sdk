/*
 * @file SLT2DLevelParser.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */


#import "SLT2DLevelParser.h"
#import "SLT2DBoard.h"
#import "SLT2DBoardLayer.h"
#import "SLTAsset.h"
#import "SLT2DAssetInstance.h"

@implementation SLT2DLevelParser

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
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[super alloc] initUniqueInstance];
    });
    
    // returns the same object each time
    return _sharedObject;
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

-(SLT2DBoard*) parseLevelBoardFromBoardNode:(NSDictionary*)theBoardNode andAssetMap:(NSDictionary*)theAssetMap
{
    NSDictionary* boardProperties = [theBoardNode objectForKey:@"properties"];
    
    NSMutableArray* layers = [[NSMutableArray alloc] init];
    NSArray* layerNodes = [theBoardNode objectForKey:@"layers"];
    NSUInteger index = 0;
    for(NSDictionary* layerNode in layerNodes) {        
        SLT2DBoardLayer* layer = [self parseLayerFromLayerNode:layerNode layerIndex:index andAssetMap:theAssetMap];
        [layers addObject:layer];
        ++index;
    }
    
    NSNumber* width = [theBoardNode objectForKey:@"width"];
    NSNumber* height = [theBoardNode objectForKey:@"height"];
    
    return [[SLT2DBoard alloc] initWithWidth:width theHeight:height layers:layers andProperties:boardProperties];
}

-(SLT2DBoardLayer*) parseLayerFromLayerNode:(NSDictionary*)theLayerNode layerIndex:(NSInteger)theLayerIndex andAssetMap:(NSDictionary*)theAssetMap
{    
    //temporarily checking for 2 names until "layerId" is removed!
    NSString* token = [theLayerNode objectForKey:@"token"];
    if (nil == token) {
        token = [theLayerNode objectForKey:@"layerId"];
    }
    SLT2DBoardLayer* layer = [[SLT2DBoardLayer alloc] initWithToken:token andLayerIndex:theLayerIndex];
    [self parseAssetInstancesFromLayer:layer assetNodes:[theLayerNode objectForKey:@"assets"] andAssetMap:theAssetMap];
    return layer;
}

-(void) parseAssetInstancesFromLayer:(SLT2DBoardLayer*)theLayer assetNodes:(NSArray*)theAssetNodes andAssetMap:(NSDictionary*)theAssetMap
{
    for (NSDictionary* assetInstanceNode in theAssetNodes) {
        NSNumber* x = [assetInstanceNode objectForKey:@"x"];
        NSNumber* y = [assetInstanceNode objectForKey:@"y"];
        NSNumber* rotation = [assetInstanceNode objectForKey:@"rotation"];
        NSString* assetId = [[assetInstanceNode objectForKey:@"assetId"] stringValue];
        SLTAsset* asset = [theAssetMap objectForKey:assetId];
        NSArray* stateIds = [assetInstanceNode objectForKey:@"states"];
        [theLayer addAssetInstance:[[SLT2DAssetInstance alloc] initWithToken:[asset token] states:[asset getInstanceStates:stateIds] properties:[asset properties] x:x y:y andRotation:rotation]];
    }
}

@end
