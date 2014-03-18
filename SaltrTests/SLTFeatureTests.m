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
#import "SLTFeature.h"

@interface SLTFeatureTests : XCTestCase
{
    SLTFeature* _feature;
    NSDictionary* _properties;
    NSDictionary* _defaultProperties;
}
@end

@implementation SLTFeatureTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_feature) {
        _properties = @{
                        @"payVaultItem": @"discountPack2",
                        @"defaultName": @"discountPack2"
                        };
        _defaultProperties  = @{
                                @"payVaultItem": @"extraMoveByCoins_a",
                                @"defaultName": @"extraMoveByCoins"
                               };
        _feature = [[SLTFeature alloc] initWithToken:@"DISCOUNT_PACK" defaultProperties:_defaultProperties andProperties:_properties];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTLevelPackObject
{
    XCTAssertNotNil(_feature, @"SLTFeature object has not been initialized properly!");
}

- (void)testToken
{
    XCTAssertEqualObjects(_feature.token, @"DISCOUNT_PACK", @"Wrong token is specified");
}

- (void)testNilProperties
{
    SLTFeature* feature = [[SLTFeature alloc] initWithToken:@"DISCOUNT_PACK" defaultProperties:_defaultProperties andProperties:nil];
    XCTAssertEqualObjects(feature.properties, _defaultProperties, @"Wrong properties are specified");
}

- (void)testProperties
{
    XCTAssertEqualObjects(_feature.properties, _properties, @"Wrong properties are specified");
}

- (void)testDefaultProperties
{
    XCTAssertEqualObjects(_feature.defaultProperties, _defaultProperties, @"Wrong properties are specified");
}

@end
