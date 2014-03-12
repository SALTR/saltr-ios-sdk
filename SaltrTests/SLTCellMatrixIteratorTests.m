/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <XCTest/XCTest.h>
#import "SLTCell.h"
#import "SLTCellMatrix.h"
#import "SLTCellMatrixIterator.h"

@interface SLTCellMatrixIteratorTests : XCTestCase
{
    SLTCellMatrixIterator* _iterator;
    SLTCellMatrix* _matrix;
}
@end

@implementation SLTCellMatrixIteratorTests

- (void)setupMatrixSample
{
    _matrix = [[SLTCellMatrix alloc] initWithWidth:6 andHeight:5];
    for (NSUInteger i = 0; i < _matrix.height; ++i) {
        for (NSUInteger j = 0 ; j < _matrix.width; ++j) {
            SLTCell* cell = [[SLTCell alloc] initWithX:j andY:i];
            XCTAssertNotNil(cell, @"SLTCell is not initialized properly!");
            [_matrix insertCell:cell atRow:j andColumn:i];
        }
    }
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (nil == _iterator) {
        [self setupMatrixSample];
        _iterator = [[SLTCellMatrixIterator alloc] initWithCellMatrix:_matrix];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTCellMatrixIteratorObject
{
    XCTAssertNotNil(_iterator, @"SLTCellMatrixIterator should be initialized properly");
}

- (void)testHasNext
{
    [_iterator reset];
    for (NSUInteger i = 0; i < _matrix.width; ++i) {
        for (NSUInteger j = 0; j < _matrix.height; ++j) {
            if (_matrix.height - 1 != j) {
                XCTAssert([_iterator hasNext], @"Matrix should have the next element, there are columns left for current row.");
            }
            if ([_iterator hasNext]) {
                SLTCell* cell = [_iterator next];
                XCTAssertNotNil(cell, @"");
            }
        }
        if (_matrix.width - 1 != i) {
            XCTAssert([_iterator hasNext], @"Matrix should have the next element, there are rows.");
        }
    }
    XCTAssertFalse([_iterator hasNext], @"There are no elements left to iterate!");
}

- (void)testNext
{
    [_iterator reset];
    SLTCell* cell = [_matrix retrieveCellAtRow:0 andColumn:0];
    for (NSUInteger i = 0; i < _matrix.width; ++i) {
        for (NSUInteger j = 0; j < _matrix.height; ++j) {
            if ([_iterator hasNext]) {
                XCTAssert([cell isKindOfClass: [SLTCell class]], @"SLTCell is not initialized properly!");
                XCTAssertEqual([NSNumber numberWithInteger:((SLTCell*)cell).x], [NSNumber numberWithInteger:i], @"The cell of matrix should have reversed X coordinate!");
                XCTAssertEqual([NSNumber numberWithInteger:((SLTCell*)cell).y], [NSNumber numberWithInteger:j], @"The cell of matrix should have reversed Y coordinate!");
                cell = [_iterator next];
            }
        }
    }
}

- (void)testReset
{
    [_iterator reset];
    while ([_iterator hasNext]) {
        SLTCell* cell = [_iterator next];
        XCTAssertNotNil(cell, @"");
    }
    XCTAssertFalse([_iterator hasNext], @"There are no elements left to iterate!");
    [_iterator reset];
    XCTAssert([_iterator hasNext], @"There are elements to iterate!");

}

@end
