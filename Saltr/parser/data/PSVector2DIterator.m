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
    NSUInteger _currentX;
    NSUInteger _currentY;
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
    return (_currentY == (_vector2D.height - 1));
}

- (BOOL)isLastRow
{
    return (_currentX == (_vector2D.width - 1));
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
        _currentX++;
        _currentY = 0;
    } else {
        _currentY++;
    }
    id nextObject = [_vector2D retrieveObjectAtRow:_currentX andColumn:_currentY];
    return nextObject;
}

- (void)reset {
    _currentX = 0;
    _currentY = 0;
}
@end
