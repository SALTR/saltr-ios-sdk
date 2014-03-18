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
#import "SLTRepository.h"
#import "SLTLevelBoardParser.h"
#import "SLTLevel.h"
#import "SLTLevelBoard.h"
#import "SLTCellMatrix.h"
#import "SLTCellMatrixIterator.h"
#import "SLTAsset.h"
#import "SLTAssetInstance.h"
#import "SLTCompositeInstance.h"
#import "SLTCell.h"

@interface LevelParserTests : XCTestCase

@end

@implementation LevelParserTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLevelParsing
{
//    SLTRepository* repository = [[SLTRepository alloc] init];
    id data = [SLTRepository objectFromStorage:@"level.json"];
    SLTLevel* level = [[SLTLevel alloc] init];
    [level updateContent:data];
    NSLog(@"BOARD DATA %@", level);
    SLTLevelBoard* levelBoard =  [level boardWithId:@"board1"];
    NSLog(@"LEVEL BOARD : %@", levelBoard);
    SLTCellMatrix* vectorBoard = levelBoard.cells;
    NSLog(@"LEVEL BOARD Vector : %@", vectorBoard);
    SLTCellMatrixIterator* iterator = [vectorBoard iterator];
    SLTCell* cell = [vectorBoard retrieveCellAtRow:0 andColumn:0];
    XCTAssertNil(iterator, @"");
    while ([iterator hasNext]) {
        cell = [iterator next];
        NSLog(@"PRINT   %@:", cell);
        XCTAssertNil(cell);
    }
}

@end
