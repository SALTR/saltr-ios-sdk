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
#import "SLTLevelBoard.h"
#import "SLTRepository.h"
#import "SLTCellMatrix.h"
#import "SLTCell.h"


@interface SLTLevelBoardTests : XCTestCase
{
    SLTLevelBoard* _levelBoard;
    SLTCellMatrix* _matrix;
    NSMutableDictionary* _properties;
    NSUInteger _width;
    NSUInteger _height;

}

@end

@implementation SLTLevelBoardTests

- (void)setupMatrixSample
{
    _width = 6;
    _height = 5;
    _matrix = [[SLTCellMatrix alloc] initWithWidth:_width andHeight:_height];
    for (NSUInteger i = 0; i < _matrix.height; ++i) {
        for (NSUInteger j = 0 ; j < _matrix.width; ++j) {
            SLTCell* cell = [[SLTCell alloc] initWithX:j andY:i];
            XCTAssertNotNil(cell, @"SLTCell is not initialized properly!");
            [_matrix insertCell:cell atRow:j andColumn:i];
        }
    }
}

- (void)setupPropertiesSample
{
    SLTRepository* repository = [[SLTRepository alloc] init];
    id data = [repository objectFromStorage:@"level.json"];
    NSDictionary* boards = [data objectForKey:@"boards"];
    XCTAssertNotNil(boards, @"Data of boards is not initialized properly");
    NSDictionary* board = [boards objectForKey:@"board1"];
    XCTAssertNotNil(board, @"Board data is not initialized properly");
    _properties = [data objectForKey:@"properties"];
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_levelBoard) {
        [self setupMatrixSample];
        [self setupPropertiesSample];
        _levelBoard = [[SLTLevelBoard alloc] initWithCellMatrix:_matrix andProperties:_properties];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLevelBoardInitialization
{
    XCTAssertNotNil(_levelBoard, @"Level board is not initializated properly.");
}

- (void)testCells
{
    XCTAssertEqualObjects(_levelBoard.cells, _matrix, @"Wrong object is specified for cells");
}

- (void)testProperties
{
    XCTAssertEqualObjects(_levelBoard.properties, _properties, @"Wrong object is specified for properties");
}

- (void)testCols
{
    XCTAssertEqual([NSNumber numberWithUnsignedInteger:_levelBoard.cols], [NSNumber numberWithUnsignedInteger:_width], @"Wrong value is specified for width");

}

- (void)testRows
{
    XCTAssertEqual([NSNumber numberWithUnsignedInteger:_levelBoard.rows], [NSNumber numberWithUnsignedInteger:_height], @"Wrong value is specified for height");
}

@end
