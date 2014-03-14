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
}
@end

@implementation SLTLevelSettingsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_levelSettings) {
        SLTRepository* repository = [[SLTRepository alloc] init];
        id data = [repository objectFromStorage:@"level.json"];
        assert([data isKindOfClass:[NSDictionary class]]);
        _levelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:data];
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

- (void)testCompositeAsset:(SLTCompositeAsset*)compositeAsset withKey:(NSString*)key
{
    XCTAssertNotNil(compositeAsset.cellInfos, @"The shift cells should be specified for composite asset");
    NSArray* cellInfos = compositeAsset.cellInfos;
    NSArray* cell0 = @[@0, @0];
    XCTAssertEqualObjects([cellInfos objectAtIndex:0], cell0, @"Wrong shift cell is specified");
    NSArray* cell6 = @[@6, @0];
    XCTAssertEqualObjects([cellInfos objectAtIndex:6], cell6, @"Wrong shift cell is specified");
    NSArray* cell13 = @[@6, @1];
    XCTAssertEqualObjects([cellInfos objectAtIndex:13], cell13, @"Wrong shift cell is specified");
    NSArray* cellLast = @[@6, @6];
    XCTAssertEqualObjects([cellInfos objectAtIndex:(cellInfos.count - 1)], cellLast, @"Wrong shift cell is specified");


    [self testAsset:compositeAsset withKey:key type:@"composite_asset" keys:@{@"COLOR": @3,
                                                            @"CARD_SUIT":  @2,
                                                            @"CARD_VALUE":  @3}];
}

- (void)testAsset:(SLTAsset*)asset withKey:(NSString*)key type:(NSString*)type keys:(NSDictionary*)keys
{
    XCTAssertNotNil(asset, @"Asset should be not nil");
    XCTAssertEqualObjects(asset.type, type, @"Wrong type specified.");
    XCTAssertEqualObjects(asset.keys, keys, @"Wrong keys specified.");
}

- (void)testAsset:(SLTAsset*)asset withKey:(NSString*)key
{
    NSDictionary* assetKeys = [asset keys];
    XCTAssert([assetKeys isKindOfClass:[NSDictionary class]]);
    XCTAssertNotNil(assetKeys, @"Asset keys are not created properly!");
    switch ([key integerValue]) {
        case 2835: {
            [self testAsset:asset withKey:key type:@"normal" keys:@{@"COLOR": @1,
                                                                    @"CARD_SUIT":  @1,
                                                                    @"CARD_VALUE":  @1}];
            break;
        } case 2836: {
            [self testAsset:asset withKey:key type:@"normal" keys:@{@"COLOR": @3,
                                                                          @"CARD_SUIT":  @3,
                                                                          @"CARD_VALUE":  @3}];
            break;
        } case 2837: {
            [self testAsset:asset withKey:key type:@"normal" keys:@{@"COLOR": @9,
                                                                          @"CARD_SUIT":  @2,
                                                                          @"CARD_VALUE":  @13}];
            break;
        } case 2838: {
            [self testAsset:asset withKey:key type:@"custom_asset" keys:@{@"COLOR": @11,
                                                                    @"CARD_SUIT":  @4,
                                                                    @"CARD_VALUE":  @8}];
            break;
        } default: {
            break;
        }
    }
}

- (void)testAssetMap
{
    NSDictionary* assetsMap = [_levelSettings assetMap];
    XCTAssertNotNil(assetsMap, @"Asset map is not created properly!");
    for (NSString* key in assetsMap) {
        id asset = [assetsMap objectForKey:key];
        XCTAssertNotNil(asset, @"Asset is not created properly!");
        XCTAssert([asset isKindOfClass:[SLTAsset class]]);
        if ([asset isKindOfClass:[SLTCompositeAsset class]]) {
            [self testCompositeAsset:asset withKey:key];
        } else {
            [self testAsset:asset withKey:key];
        }
    }
}

- (void)testKeySetMap
{
    NSDictionary* keySet = [_levelSettings keySetMap];
    NSDictionary* colorKey = [keySet objectForKey:@"COLOR"];
    XCTAssert([colorKey isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([colorKey objectForKey:@"1"], @"white", @"The value of key=1 should be 'white'!");
    XCTAssertEqualObjects([colorKey objectForKey:@"8"], @"magenta", @"The value of key=8 should be 'magenta'!");
    XCTAssertEqualObjects([colorKey objectForKey:@"13"], @"brown", @"The value of key=13 should be 'brown'!");

    NSDictionary*  cardSuitKey= [keySet objectForKey:@"CARD_SUIT"];
    XCTAssert([cardSuitKey isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"1"], @"spade", @"The value of key=1 should be 'spade'!");
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"2"], @"club", @"The value of key=2 should be 'club'!");
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"3"], @"heart", @"The value of key=3 should be 'heart'!");
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"4"], @"diamond", @"The value of key=4 should be 'diamond'!");

    NSDictionary*  cardValueKey = [keySet objectForKey:@"CARD_VALUE"];
    XCTAssert([cardValueKey isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([cardValueKey objectForKey:@"1"], @"2", @"The value of key=1 should be '2'!");
    XCTAssertEqualObjects([cardValueKey objectForKey:@"9"], @"10", @"The value of key=9 should be '10'!");
    XCTAssertEqualObjects([cardValueKey objectForKey:@"10"], @"ace", @"The value of key=10 should be 'ace'!");
    XCTAssertEqualObjects([cardValueKey objectForKey:@"13"], @"king", @"The value of key=13 should be 'king'!");
}

- (void)testStateMap
{
    NSDictionary* stateMap = [_levelSettings stateMap];
    XCTAssertEqualObjects([stateMap objectForKey:@"534"], @"state1", @"The value of state with Id = 534 should be 'state1'!");
    XCTAssertEqualObjects([stateMap objectForKey:@"535"], @"state2", @"The value of state with Id = 535 should be 'state2'!");
}

@end
