/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSVector2DIterator.h"
#import "PSVector2D.h"

@interface PSVector2DIterator () {
    NSUInteger _currentRow;
    NSUInteger _currentColumn;
}
@end

@implementation PSVector2DIterator

@synthesize vector2D = _vector2D;

- (id)initVector2DItaratorWithVector:(PSVector2D*)vector2D
{
    self = [super init];
    if (self) {
        _vector2D = vector2D;
        assert(nil != _vector2D);
        if (nil == _vector2D) {
            return  nil;
        }
        [self reset];
    }
    return self;
}

- (BOOL)isLastColumn
{
    return (_currentColumn == (_vector2D.width - 1));
}

- (BOOL)isLastRow
{
    return (_currentRow == (_vector2D.height - 1));
}

- (BOOL)hasNext
{
    return !([self isLastColumn] && [self isLastRow]);
}

- (id)nextObject
{
    if (![self hasNext]) {
        return nil;
    }
    if ([self isLastColumn] && !([self isLastRow])) {
        _currentRow++;
        _currentColumn = 0;
    } else {
        _currentColumn++;
    }
    id nextObject = [_vector2D retrieveObjectAtRow:_currentRow andColumn:_currentColumn];
    return nextObject;
}

- (void)reset {
    _currentRow = 0;
    _currentColumn = 0;
}
@end
