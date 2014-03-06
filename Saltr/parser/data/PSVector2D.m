/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSVector2D.h"
#import "PSVector2DIterator.h"

@interface PSVector2D () {
    NSMutableArray* _rows;
    NSMutableArray* _colums;
    NSUInteger _rowsCount;
    NSUInteger _columsCount;
    PSVector2DIterator* _iterator;
}
@end

@implementation PSVector2D

@synthesize width = _width;
@synthesize height = _height;

- (id) initWithWidth:(NSUInteger)theWidth andHeight:(NSUInteger)theHeight
{
    self = [super init];
    if (self) {
        if (theWidth <= 0 || theHeight <= 0) {
            return nil;
        }
        _rowsCount = theHeight;
        _columsCount = theWidth;
        _width = theWidth;
        _height = theHeight;
        _rows = [[NSMutableArray alloc] initWithCapacity:_rowsCount];
        for (NSUInteger i = 0; i < _rowsCount; ++i) {
            _rows[i] = [[NSMutableArray alloc] initWithCapacity:_columsCount];
            for (int j = 0; j < _columsCount; ++j) {
                [[_rows objectAtIndex:i] addObject:[[NSNull alloc] init]];
            }
        }
        _iterator = nil;
    }
    return self;
}

- (void)addObject:(id)object atRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if (object == nil || row >= _rowsCount || column >= _columsCount ) {
        return;
    }
    [(NSMutableArray*)([_rows objectAtIndex:row]) replaceObjectAtIndex:column withObject:object];
}

- (id)retrieveObjectAtRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if (row >= _rowsCount || column >= _columsCount ) {
        return nil;
    }
    assert(_rows);
    id object = [[_rows objectAtIndex:row] objectAtIndex:column];
    assert(object);
    return object;
}

- (PSVector2DIterator*)iterator
{
    if (nil == _iterator) {
        _iterator = [[PSVector2DIterator alloc] initVector2DItaratorWithVector:self];
    }
    return  _iterator;
}

@end
