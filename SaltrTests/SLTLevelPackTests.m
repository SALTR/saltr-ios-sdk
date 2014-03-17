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
#import "SLTLevelPack.h"
#import "SLTRepository.h"

@interface SLTLevelPackTests : XCTestCase
{
    SLTLevelPack* _levelPack;
    NSMutableArray* _levelPacks;
    NSDictionary* _levelPackData;
}
@end

@implementation SLTLevelPackTests

- (void)setupLevelPack
{
    SLTRepository* repository = [[SLTRepository alloc] init];
    id data = [repository objectFromStorage:@"appdata.json"];
    XCTAssertNotNil(data, @"Data from JSON has not been extracted properly!");
    _levelPacks =  [[NSMutableArray alloc] initWithArray:[[data objectForKey:@"responseData"] objectForKey:@"levelPackList"]];
    XCTAssertNotNil(_levelPacks, @"Level packs have not been initialized properly!");
    _levelPackData = [_levelPacks objectAtIndex:0];
    XCTAssertNotNil(_levelPackData, @"Level pack has not been initialized properly!");
    NSArray* levels = [_levelPackData objectForKey:@"levelList"];
    NSString* token = [_levelPackData objectForKey:@"token"];
    NSString* index = [_levelPackData objectForKey:@"order"];
    _levelPack = [[SLTLevelPack alloc] initWithToken:token levels:levels andIndex:index];
    XCTAssertNotNil(_levelPack, @"SLTLevelPack object has not been initialized properly!");
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_levelPack) {
        [self setupLevelPack];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testSLTLevelPackObject
{
    XCTAssertNotNil(_levelPack, @"SLTLevelPack object has not been initialized properly!");
}

- (void)testToken
{
    NSString* token = [_levelPackData objectForKey:@"token"];
    XCTAssertEqualObjects(_levelPack.token, token, @"Wrong token is specified");
}

- (void)testLevels
{
    NSArray* levels = [_levelPackData objectForKey:@"levelList"];
    XCTAssertEqualObjects(_levelPack.levels, levels, @"Wrong level list is specified");
}

- (void)testIndex
{
    NSString* index = [_levelPackData objectForKey:@"order"];
    XCTAssertEqualObjects(_levelPack.index, index, @"Wrong index is specified");
}

@end
