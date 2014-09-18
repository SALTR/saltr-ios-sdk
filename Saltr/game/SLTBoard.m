/*
 * @file SLTBoard.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoard.h"
#import "SLTBoardLayer.h"

@implementation SLTBoard

@synthesize layers = _layers;
@synthesize properties = _properties;

- (id) initWithLayers:(NSMutableArray*)theLayers andProperties:(NSDictionary*)theProperties
{
    self = [super init];
    if (self) {
        _layers = theLayers;
        _properties = theProperties;
    }
    return self;
}

- (void) regenerate
{
    for (NSUInteger i=0; i<_layers.count; ++i) {
        SLTBoardLayer* boardLayer = [_layers objectAtIndex:i];
        assert(nil != boardLayer);
        [boardLayer regenerate];
    }
}

@end
