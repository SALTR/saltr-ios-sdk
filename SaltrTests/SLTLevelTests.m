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
#import "SLTLevel.h"
#import "SLTRepository.h"
#import "SLTLevelSettings.h"
#import "SLTLevelBoardParser.h"
#import "SLTLevelBoard.h"

@interface SLTLevelTests : XCTestCase
{
    SLTLevel* _level;
    NSDictionary* _properties;
    NSDictionary* _data;
}
@end

@implementation SLTLevelTests

- (void)setupDefaultLevel
{
    NSMutableArray* colors = [NSMutableArray arrayWithObjects:@"blue", @"yellow", @"orange", @"green", nil];
    NSMutableArray* starsRange = [NSMutableArray arrayWithObjects:@100, @160, @250, nil];
    _properties = @{
                    @"colors": colors,
                    @"appendingRowsCount": @1,
                    @"cellHeight": @40,
                    @"cellWidth": @40,
                    @"playTime": @60,
                    @"starsRange": starsRange,
                    @"rowAddingSpeed": @5000,
                    @"type": @"match",
                    @"clickCount": @30,
                    @"maxStrawberryCount ": @10
                    };
    _level = [[SLTLevel alloc] initWithLevelId:@"286" index:@"0" contentDataUrl:@"http://saltadmin.includiv.com/static_data/d2066eaf-6206-8975-3bb1-0541f196fa3c/levels/314.json" properties:_properties andVersion:@"4"];
    XCTAssertNotNil(_level, @"SLTLevel object allocation/initialization fails");
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_level) {
        [self setupDefaultLevel];
        SLTRepository* repository = [[SLTRepository alloc] init];
        if (!_data) {
            _data = [repository objectFromStorage:@"level.json"];
            XCTAssert(_data, @"Data from JSON has not been extracted properly!");
        }
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTLevelObject
{
    XCTAssertNotNil(_level, @"SLTLevel object allocation/initialization fails");
}

#pragma mark - Testing properties

- (void)testLevelId
{
    XCTAssertEqualObjects(_level.levelId, @"286", @"Wrong level ID is specified");
}

- (void)testContentDataUrl
{
    NSString* contentDataUrl = @"http://saltadmin.includiv.com/static_data/d2066eaf-6206-8975-3bb1-0541f196fa3c/levels/314.json";
    XCTAssertEqualObjects(_level.contentDataUrl, contentDataUrl, @"Wrong level data URL is specified");
}

- (void)testIndex
{
    NSString* index = @"0";
    XCTAssertEqualObjects(_level.index, index, @"Wrong level index is specified");
}

- (void)testProperties
{
    XCTAssertEqualObjects(_level.properties, _properties, @"Wrong level properties are specified");
}

- (void)testVersion
{
    NSString* version = @"4";
    XCTAssertEqualObjects(_level.version, version, @"Wrong level version is specified");
}

- (void)testContentReady
{
    XCTAssertFalse(_level.contentReady, @"Level content data should not be ready yet");
    [_level updateContent:_data];
    XCTAssertTrue(_level.contentReady, @"Level content data should be ready to use!");
}

- (void)testLevelSettings
{
    SLTLevelSettings* updatedLevelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:_data];
    XCTAssertNotNil(updatedLevelSettings, @"Level Settings has not been initialized properly!");
    XCTAssertNil(_level.levelSettings, @"Level settings object should be nil before calling updateContent function!");
    [_level updateContent:_data];
    XCTAssertNotNil(_level.levelSettings, @"Level settings object should not be nil after calling updateContent function!");
    XCTAssertEqualObjects(_level.levelSettings.assetMap, updatedLevelSettings.assetMap, @"The level settings asset map have not been updated properly!!!");
    XCTAssertEqualObjects(_level.levelSettings.keySetMap, updatedLevelSettings.keySetMap, @"The level settings keySetMap have not been updated properly!!!");
    XCTAssertEqualObjects(_level.levelSettings.stateMap, updatedLevelSettings.stateMap, @"The level settings stateMap have not been updated properly!!!");
}

#pragma mark - Testing public methods

- (void)testBoardWithId
{
    XCTAssertNotNil(_level, @"Level has not been set up properly!");
    XCTAssertNil([_level boardWithId:@"board1"], @"Board has not been updated properly!");
    XCTAssertNil( [_level boardWithId:@"board2"], @"Board has not been updated properly!");
    [_level updateContent:_data];
    XCTAssertNotNil([_level boardWithId:@"board1"], @"Board has not been updated properly!");
    XCTAssertNotNil( [_level boardWithId:@"board2"], @"Board has not been updated properly!");
}

- (void)testUpdateContent
{
    XCTAssertNotNil(_data, @"Data from JSON has not been extracted properly!");
    NSDictionary* updatedProperties = @{
                                        @"level_prop_1": @"level_prop_val_1",
                                        @"level_prop_2": @"level_prop_val_2"
                                        };
    XCTAssertNotNil(updatedProperties, @"Updated properties are nil");
    XCTAssertNotNil(_level, @"Level has not been setuped properly!");
    [_level updateContent:_data];
    XCTAssertNotNil(_level, @"Level has not been updated properly!");
    XCTAssertEqualObjects( _level.properties, updatedProperties, @"The level properties have not been updated properly!!!");
    SLTLevelBoard* board1 = [_level boardWithId:@"board1"];
    SLTLevelBoard* board2 = [_level boardWithId:@"board2"];
    XCTAssertNotNil(board1, @"Board has not been updated properly!");
    XCTAssertNotNil(board2, @"Board has not been updated properly!");
}

// TODO It is not possible to pass new data for regenerating all boards with generateAllBoards function. User need to call updateContent function to pass the data at first, which calls the mentioned function as well, so there is no meaning to call it twice.
- (void)testGenerateAllBoards
{
//    XCTAssertNil([_level boardWithId:@"board1"], @"Board has not been updated properly!");
//    XCTAssertNil( [_level boardWithId:@"board2"], @"Board has not been updated properly!");
//    [_level generateAllBoards];
//    XCTAssertNotNil([_level boardWithId:@"board1"], @"Board has not been updated properly!");
//    XCTAssertNotNil( [_level boardWithId:@"board2"], @"Board has not been updated properly!");
}

// TODO It is not possible to pass new data for regenerating the board with generateBoardWithId function. User need to call updateContent function to pass the data at first, which calls the mentioned function as well, so there is no meaning to call it twice.
- (void)testGenerateBoardWithId
{
//    XCTAssertNil([_level boardWithId:@"board1"], @"Board has not been updated properly!");
//    [_level generateBoardWithId:@"board1"];
//    XCTAssertNotNil( [_level boardWithId:@"board1"], @"Board has not been updated properly!");
}
@end
