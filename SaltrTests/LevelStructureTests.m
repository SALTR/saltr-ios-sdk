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
#import "PSLevelStructure.h"

@interface LevelStructureTests : XCTestCase

@end

@implementation LevelStructureTests

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

- (void)testLevelStructureObject
{
    PSLevelStructure* level = [[PSLevelStructure alloc] initWithLevelId:@"level_1" index:0 dataUrl:@"http://example.com" properties:nil andVersion:@"v.01"];
    XCTAssertNotNil(level, @"Object allocation/initialization fails");
}

@end
