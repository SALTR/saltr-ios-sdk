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
#import "SLTLevelSettings.h"
#import "SLTRepository.h"
#import "SLTLevelBoardParser.h"
#import "SLTAsset.h"
#import "SLTCompositeAsset.h"

@interface SLTLevelSettingsTests : XCTestCase
{
    SLTLevelSettings* _levelSettings;
    NSMutableDictionary* _assetMap;
    NSMutableDictionary* _keySetMap;
    NSMutableDictionary* _stateMap;
}
@end

@implementation SLTLevelSettingsTests


- (NSDictionary*)stateMap
{
    return  @{@"534": @"state1", @"535": @"state2"};
}

- (NSDictionary*)keySetMap
{
    return  @{ @"keySets": @{
                    @"COLOR": @{
                        @"1": @"white",
                        @"2": @"black",
                        @"3": @"red",
                    },
                    @"CARD_SUIT": @{
                        @"1": @"spade",
                        @"2": @"club",
                        @"3": @"heart",
                        @"4": @"diamond"
                    },
                    @"CARD_VALUE": @{
                        @"1": @"2",
                        @"2": @"3",
                        @"3": @"4",
                        @"4": @"5"
                    }
                    }
               };
}

- (NSMutableDictionary*)assetsMap
{
    NSMutableDictionary* assetsMap = [[NSMutableDictionary alloc] init];
    SLTAsset* compositeAsset = [[SLTCompositeAsset alloc] initWithCellInfos:@[@[@1,@2], @[@7, @5]] type:@"composite_asset" andKeys: @{ @"keys": @{
                                                                                                                                               @"CARD_SUIT": @2,
                                                                                                                                               @"COLOR": @3,
                                                                                                                                               @"CARD_VALUE": @3
                                                                                                                                               }}];
    [assetsMap setObject:compositeAsset forKey:@"2839"];
    SLTAsset* asset = [[SLTAsset alloc] initWithType:@"composite_asset" andKeys: @{ @"keys": @{
                                                                                            @"CARD_SUIT": @1,
                                                                                            @"COLOR": @2,
                                                                                            @"CARD_VALUE": @2
                                                                                            }}];
    [assetsMap setObject:asset forKey:@"2840"];
    return assetsMap;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_levelSettings) {
        _levelSettings = [[SLTLevelSettings alloc] initWithAssetMap:[self assetsMap] keySetMap:[self keySetMap] andStateMap:[self stateMap]];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTLevelSettingsObject
{
    XCTAssertNotNil(_levelSettings, @"SLTLevelSettings has not been initialized properly!");
}

- (void)testKeySetMap
{
    XCTAssertEqualObjects(_levelSettings.keySetMap, [self keySetMap], @"Keyset does not initialized properly!");
}

- (void)testStateMap
{
    XCTAssertEqualObjects(_levelSettings.stateMap, [self stateMap], @"State map does not initialized properly!");
}

- (void)testAssetsMap
{
    XCTAssertEqualObjects(_levelSettings.assetMap, [self assetsMap], @"Asset map does not initialized properly!");
}

@end
