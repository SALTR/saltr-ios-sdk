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
#import "SLTCompositeInstance.h"

@interface SLTCompositeInstanceTests : XCTestCase
{
    SLTCompositeInstance* _compositeInstance;
    NSDictionary* _keysData;
    NSMutableArray* _cellsData;
}

@end

@implementation SLTCompositeInstanceTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _keysData = @{
                  @"CARD_VALUE": [NSNumber numberWithInt:13],
                  @"CARD_SUIT": [NSNumber numberWithInt:2],
                  @"COLOR": [NSNumber numberWithInt:9],
                  };
    _cellsData = [NSMutableArray arrayWithObjects:@[@0, @2], @[@4, @3], @[@6, @1], nil];
    XCTAssert(_cellsData);
    _compositeInstance = [[SLTCompositeInstance alloc] initWithCells:_cellsData state:@"state1" type:@"composite_asset" andKeys:_keysData];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCells
{
    XCTAssertNotNil(_compositeInstance.cells, @"The cells of composite instance has not been initialized properly!");
    NSArray* cells = _compositeInstance.cells;
    NSArray* cell0 = [_cellsData objectAtIndex:0];
    XCTAssertEqualObjects([cells objectAtIndex:0], cell0, @"Wrong cell is specified");
    NSArray* cell1 = [_cellsData objectAtIndex:1];
    XCTAssertEqualObjects([cells objectAtIndex:1], cell1, @"Wrong cell is specified");
    NSArray* cell2 = [_cellsData objectAtIndex:2];
    XCTAssertEqualObjects([cells objectAtIndex:(cells.count - 1)], cell2, @"Wrong cell is specified");
}

- (void)testCompositeInstanceTestsObject
{
    XCTAssertNotNil(_compositeInstance, @"SLTCompositeInstance has not been initialized properly!");
}

- (void)testType
{
    XCTAssertEqualObjects(_compositeInstance.type, @"composite_asset", @"Wrong type has been specified!");
}

- (void)testState
{
    XCTAssertEqualObjects(_compositeInstance.state, @"state1", @"Wrong type has been specified!");
}

- (void)testKeys
{
    XCTAssertEqualObjects(_compositeInstance.keys, _keysData, @"Wrong keys have been specified!");
}

@end
