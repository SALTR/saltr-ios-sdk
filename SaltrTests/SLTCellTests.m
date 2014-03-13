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

@interface SLTCellTests : XCTestCase
{
    SLTCell* _cell;
}
@end

@implementation SLTCellTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_cell) {
        _cell = [[SLTCell alloc] initWithX:5 andY:1];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTCellObject
{
    XCTAssertNotNil(_cell, @"SLTCell has not been initialized properly!");
}

- (void)testX
{
    XCTAssertEqual([NSNumber numberWithUnsignedLong:_cell.x], @5, "Wrong matrix height");

}

- (void)testY
{
    XCTAssertEqual([NSNumber numberWithUnsignedLong:_cell.y], @1, "Wrong matrix height");

}

@end
