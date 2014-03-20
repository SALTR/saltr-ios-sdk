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
#import "SLTAssetInstance.h"

@interface SLTAssetInstanceTests : XCTestCase
{
    SLTAssetInstance* _assetInstance;
}
@end

@implementation SLTAssetInstanceTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_assetInstance) {
        NSDictionary* keys = @{
                               @"CARD_VALUE": [NSNumber numberWithInt:13],
                               @"CARD_SUIT": [NSNumber numberWithInt:2],
                               @"COLOR": [NSNumber numberWithInt:9],
                               };
        _assetInstance = [[SLTAssetInstance alloc] initWithState:@"state1" type:@"custom_asset" andKeys:keys];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTAssetInstanceObject
{
    XCTAssertNotNil(_assetInstance, @"SLTAsset has not been initialized properly!");
}

- (void)testType
{
    XCTAssertEqual(_assetInstance.type, @"custom_asset", @"Wrong value is specified for type!");
}

- (void)testKeys
{
    XCTAssertNotNil(_assetInstance.keys, @"Keys property has not been initialized properly");
    XCTAssertEqualObjects([_assetInstance.keys objectForKey:@"CARD_VALUE"], @13, @"Wrong value is specified for CARD_VALUE key");
    XCTAssertEqualObjects([_assetInstance.keys objectForKey:@"CARD_SUIT"], @2, @"Wrong value is specified for CARD_SUIT key");
    XCTAssertEqualObjects([_assetInstance.keys objectForKey:@"COLOR"], @9, @"Wrong value is specified for COLOR key");
}

- (void)testState
{
    XCTAssertEqualObjects(_assetInstance.state, @"state1", @"Wrong value is specified for state!");

}

@end
