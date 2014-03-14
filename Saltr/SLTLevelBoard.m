/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevelBoard.h"
#import "SLTCellMatrix.h"

@implementation SLTLevelBoard

@synthesize rows = _rows;
@synthesize cols = _cols;
@synthesize cells = _cells;
@synthesize properties = _properties;

- (id) initWithCellMatrix:(SLTCellMatrix*)theCells andProperties:(NSDictionary*)theProperties
{
    self = [super init];
    if (self) {
        _cells = theCells;
        _cols = _cells.width;
        _rows = _cells.height;
        _properties = theProperties;
    }
    return self;
}

@end
