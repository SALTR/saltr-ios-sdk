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
#import "SLTAsset.h"

@interface SLTAssetTests : XCTestCase
{
    SLTAsset* _asset;
}
@end

@implementation SLTAssetTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_asset) {
        NSDictionary* keys = @{
                               @"CARD_VALUE": [NSNumber numberWithInt:13],
                               @"CARD_SUIT": [NSNumber numberWithInt:2],
                               @"COLOR": [NSNumber numberWithInt:9],
                               };
        _asset = [[SLTAsset alloc] initWithType:@"custom_asset" andKeys:keys];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTAssetObject
{
    XCTAssertNotNil(_asset, @"SLTAsset has not been initialized properly!");
}

- (void)testType
{
    XCTAssertEqual(_asset.type, @"custom_asset", @"Wrong value is specified for type");
}

- (void)testKeys
{
    XCTAssertNotNil(_asset.keys, @"Keys property has not been initialized properly");
    XCTAssertEqual([[_asset.keys objectForKey:@"CARD_VALUE"] integerValue], 13, @"Wrong value is specified for CARD_VALUE key");
    XCTAssertEqual([[_asset.keys objectForKey:@"CARD_SUIT"] integerValue], 2, @"Wrong value is specified for CARD_SUIT key");
    XCTAssertEqual([[_asset.keys objectForKey:@"COLOR"] integerValue], 9, @"Wrong value is specified for COLOR key");
}

@end
