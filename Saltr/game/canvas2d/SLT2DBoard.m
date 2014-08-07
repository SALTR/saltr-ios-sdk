/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLT2DBoard.h"

@implementation SLT2DBoard

@synthesize width = _width;
@synthesize height = _height;

- (id) initWithWidth:(NSNumber * )theWidth theHeight:(NSNumber *)theHeight layers:(NSMutableArray*)theLayers andProperties:(NSDictionary*)theProperties
{
    self = [super initWithLayers:theLayers andProperties:theProperties];
    if (self) {
        _width = theWidth;
        _height = theHeight;
    }
    return self;
}

@end
