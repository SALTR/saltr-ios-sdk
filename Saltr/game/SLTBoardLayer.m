/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoardLayer.h"

@implementation SLTBoardLayer

@synthesize layerId = _layerId;
@synthesize layerIndex = _layerIndex;

-(id) initWithLayerId:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex
{
    self = [super init];
    if (self) {
        _layerId = theLayerId;
        _layerIndex = theLayerIndex;
    }
    return self;
}

-(void) regenerate
{
    //override
}

@end
