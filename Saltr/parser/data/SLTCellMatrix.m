/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCell.h"
#import "SLTCellMatrix.h"
#import "SLTCellMatrixIterator.h"

@interface SLTCellMatrix () {
    SLTCellMatrixIterator* _iterator;
    NSMutableArray* _rawData;
}
@end

@implementation SLTCellMatrix

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
    _rawData = [[NSMutableArray alloc] initWithCapacity:_height];
    for (NSUInteger i = 0; i < _height; ++i) {
        _rawData[i] = [[NSMutableArray alloc] initWithCapacity:_width];
        for (int j = 0; j < _width; ++j) {
            [[_rawData objectAtIndex:i] addObject:[[NSNull alloc] init]];
        }
    }
}

- (void)insertCell:(SLTCell*)cell atRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if (cell == nil || row >= _width || column >= _height ) {
        return;
    }
    [(NSMutableArray*)([_rawData objectAtIndex:column]) replaceObjectAtIndex:row withObject:cell];
}

- (SLTCell*)retrieveCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column
{
    if (row >= _width || column >= _height ) {
        return nil;
    }
    assert(_rawData);
    id object = [[_rawData objectAtIndex:column] objectAtIndex:row];
    assert(object);
    return object;
}

- (SLTCellMatrixIterator*)iterator
{
    if (nil == _iterator) {
        _iterator = [[SLTCellMatrixIterator alloc] initWithCellMatrix:self];
    }
    return  _iterator;
}

@end
