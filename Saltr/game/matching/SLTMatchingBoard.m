/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTMatchingBoard.h"
#import "SLTCells.h"

@implementation SLTMatchingBoard

@synthesize cells = _cells;

@synthesize rows = _rows;

@synthesize cols = _cols;

-(id) initWithCells:(SLTCells*)theCells layers:(NSMutableArray *)theLayers andProperties:(NSDictionary *)theProperties
{
    self = [super initWithLayers:theLayers andProperties:theProperties];
    if (self) {
        _cells = theCells;
        _cols = [theCells width];
        _rows = [theCells height];
    }
    return self;
}

@end
