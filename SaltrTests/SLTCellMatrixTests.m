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
#import "SLTCellMatrixIterator.h"
#import "SLTCellMatrix.h"
#import "SLTCell.h"


@interface SLTCellMatrixTests : XCTestCase
{
    SLTCellMatrix* _cellMatrix;
}
@end

@implementation SLTCellMatrixTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_cellMatrix) {
        NSUInteger columns = 6;
        NSUInteger rows = 5;
        _cellMatrix = [[SLTCellMatrix alloc] initWithWidth:columns andHeight:rows];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTCellMatrixObject
{
    XCTAssertNotNil(_cellMatrix, @"SLTCellMatrix is not initialized properly!");
}

- (void)testInsertCell
{
    for (NSUInteger i = 0; i < _cellMatrix.height; ++i) {
        for (NSUInteger j = 0 ; j < _cellMatrix.width; ++j) {
            SLTCell* cell = [[SLTCell alloc] initWithX:j andY:i];
            XCTAssertNotNil(cell, @"SLTCell is not initialized properly!");
            [_cellMatrix insertCell:cell atRow:j andColumn:i];
        }
    }
}

- (void)testRetrieveCell
{
    [self testInsertCell];
    for (NSUInteger i = 0; i < _cellMatrix.height; ++i) {
        for (NSUInteger j = 0 ; j < _cellMatrix.width; ++j) {
            id cell = [_cellMatrix retrieveCellAtRow:j andColumn:i];
            XCTAssert([cell isKindOfClass: [SLTCell class]], @"SLTCell is not initialized properly!");
            XCTAssertEqual([NSNumber numberWithInteger:((SLTCell*)cell).x], [NSNumber numberWithInteger:j], @"The cell of matrix should have reversed X coordinate!");
              XCTAssertEqual([NSNumber numberWithInteger:((SLTCell*)cell).y], [NSNumber numberWithInteger:i], @"The cell of matrix should have reversed Y coordinate!");
        }
    }
}

- (void)testWidth
{
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:_cellMatrix.width ], @6, "Wrong matrix width");
}

- (void)testHeight
{
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:_cellMatrix.height ], @5, "Wrong matrix height");

}

- (void)testIterator
{
    [self testInsertCell];
    SLTCellMatrixIterator* iterator = [_cellMatrix iterator];
    XCTAssertNotNil(iterator, @"Iterator should be initialized properly!");
}


@end
