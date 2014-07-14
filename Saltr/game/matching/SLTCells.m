/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCells.h"
#import "SLTCellsIterator.h"

@implementation SLTCells

@synthesize width = _width;
@synthesize height = _height;
@synthesize iterator = _iterator;
@synthesize rawData = _rawData;

-(id) initWithWidth:(NSInteger)theWidth andHeight:(NSInteger)theHeight
{
    self = [super init];
    if (self) {
        _width = theWidth;
        _height = theHeight;
        _rawData = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < _width * _height; ++i) {
            [_rawData addObject:[NSNull null]];
        }
        _iterator = [[SLTCellsIterator alloc] initWithCells:self];
    }
    return self;
}

-(void) insertCell:(SLTCell*)theCell atCol:(NSInteger)theCol andRow:(NSInteger)theRow
{
    [_rawData replaceObjectAtIndex:(theRow * _width) + theCol withObject:theCell];
}

-(SLTCell*) retrieveCellAtCol:(NSInteger)theCol andRow:(NSInteger)theRow
{
    return [_rawData objectAtIndex:(theRow * _width) + theCol];
}

@end
