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
#import "SLTChunkAssetInfo.h"

@interface SLTChunkAssetInfoTests : XCTestCase
{
    SLTChunkAssetInfo* _chunkAssetInfo;
}

@end

@implementation SLTChunkAssetInfoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_chunkAssetInfo) {
        _chunkAssetInfo = [[SLTChunkAssetInfo alloc] initWithAssetId:@"2836" count:0 andStateId:@"534"];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTChunkAssetInfoObject
{
    XCTAssertNotNil(_chunkAssetInfo, @"SLTChunkAssetInfo has not been initialized properly!");
}

- (void)testAssetId
{
    XCTAssertEqualObjects(_chunkAssetInfo.assetId, @"2836", @"Wrong assetId is specified");
}

- (void)testStateId
{
    XCTAssertEqualObjects(_chunkAssetInfo.stateId, @"534", @"Wrong stateId is specified");
}

- (void)testCount
{
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:_chunkAssetInfo.count], @0, "Wrong count is specified");
}

@end
