/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCellsIterator.h"
#import "SLTCells.h"

@interface SLTCellsIterator() {
    SLTCells* _cells;
    NSUInteger _vectorLenght;
    NSInteger _currentPosition;
}
@end

@implementation SLTCellsIterator

-(id) initWithCells:(SLTCells*)theCells
{
    self = [super init];
    if (self) {
        _cells = theCells;
        [self reset];
    }
    return self;
}

-(BOOL) hasNext
{
    return _currentPosition != _vectorLenght;
}

-(SLTCell*) next
{
    return [[_cells rawData] objectAtIndex:_currentPosition++];
}

-(void) reset
{
    _vectorLenght = [[_cells rawData] count];
    _currentPosition = 0;
}

@end
