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
#import "PSLevelBoard.h"
#import "SLTRepository.h"
#import "PSLevelStructure.h"

@interface LevelBoardTests : XCTestCase
{
    PSLevelBoard* _levelBoard;
}

@end

@implementation LevelBoardTests

- (void)setUp
{
    [super setUp];
    SLTRepository* repository = [[SLTRepository alloc] init];
    id data = [repository objectFromStorage:@"level.json"];
    NSDictionary* boards = [data objectForKey:@"boards"];
    NSDictionary* properties = [data objectForKey:@"properties"];
    PSLevelStructure* level = [[PSLevelStructure alloc] initWithLevelId:@"level_1" index:0 dataUrl:@"http://example.com" properties:properties andVersion:@"v.01"];
    _levelBoard = [[PSLevelBoard alloc] initWithRawBoard:boards andOwnerLevel:level];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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

- (void)testChunksRegeneration
{
    
}

- (void)testComposites
{
}

- (void)testChunks
{
    
}

@end
