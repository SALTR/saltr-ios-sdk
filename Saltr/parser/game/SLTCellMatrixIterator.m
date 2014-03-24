/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCellMatrixIterator.h"
#import "SLTCellMatrix.h"
#import "SLTCell.h"

@interface SLTCellMatrixIterator () {
    NSUInteger _currentX;
    NSUInteger _currentY;
    SLTCellMatrix* _cells;
}
@end

@implementation SLTCellMatrixIterator

- (id)initWithCellMatrix:(SLTCellMatrix*)matrix
{
    self = [super init];
    if (self) {
        _cells = matrix;
        assert(nil != _cells);
        if (nil == _cells) {
            return  nil;
        }
        [self reset];
    }
    return self;
}

- (BOOL)isLastColumn
{
    return (_currentY == (_cells.height - 1));
}

- (BOOL)isLastRow
{
    return (_currentX == (_cells.width - 1));
}

- (BOOL)hasNext
{
    return !([self isLastColumn] && [self isLastRow]);
}

- (SLTCell*)next
{
    if (![self hasNext]) {
        return nil;
    }
    if ([self isLastColumn] && !([self isLastRow])) {
        _currentX++;
        _currentY = 0;
    } else {
        _currentY++;
    }
    SLTCell* nextObject = [_cells retrieveCellAtRow:_currentX andColumn:_currentY];
    return nextObject;
}

- (void)reset {
    _currentX = 0;
    _currentY = 0;
}

@end
