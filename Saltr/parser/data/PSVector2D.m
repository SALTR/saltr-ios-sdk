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
    NSMutableArray* _matrix;
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
        _width = theWidth;
        _height = theHeight;
        _iterator = nil;
        [self setupWithEmptyObjects];
    }
    return self;
}

- (void)setupWithEmptyObjects
{
    assert(_width >= 0 && _height >= 0);
    _matrix = [[NSMutableArray alloc] initWithCapacity:_height];
    for (NSUInteger i = 0; i < _height; ++i) {
        _matrix[i] = [[NSMutableArray alloc] initWithCapacity:_width];
        for (int j = 0; j < _width; ++j) {
            [[_matrix objectAtIndex:i] addObject:[[NSNull alloc] init]];
        }
    }
}

- (void)insertObject:(id)object atRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if (object == nil || row >= _width || column >= _height ) {
        return;
    }
    NSLog(@"INSERTED OBJECT : %@", object);
    [(NSMutableArray*)([_matrix objectAtIndex:column]) replaceObjectAtIndex:row withObject:object];
}

- (id)retrieveObjectAtRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if (row >= _width || column >= _height ) {
        return nil;
    }
    assert(_matrix);
    id object = [[_matrix objectAtIndex:column] objectAtIndex:row];
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
