/*
 * @file SLT2DBoardLayer.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLT2DBoardLayer.h"
#import "SLT2DAssetInstance.h"


@implementation SLT2DBoardLayer

@synthesize assetInstances = _assetInstances;

-(id) initWithLayerId:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex
{
    self = [super initWithLayerId:theLayerId andLayerIndex:theLayerIndex];
    if (self) {
        _assetInstances = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) addAssetInstance:(SLT2DAssetInstance *)theAssetInstance
{
    [_assetInstances addObject:theAssetInstance];
}

@end
