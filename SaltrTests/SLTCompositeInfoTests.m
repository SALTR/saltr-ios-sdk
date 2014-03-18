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
#import "SLTCompositeInfo.h"
#import "SLTLevelSettings.h"
#import "SLTCell.h"
#import "SLTRepository.h"
#import "SLTLevelBoardParser.h"
#import "SLTCompositeAsset.h"
#import "SLTCompositeInstance.h"

@interface SLTCompositeInfoTests : XCTestCase
{
    SLTCompositeInfo* _compositeInfo;
    SLTLevelSettings* _levelSettings;
    SLTCell* _cell;
}

@end

@implementation SLTCompositeInfoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_compositeInfo) {
        if (!_levelSettings) {
            id data = [SLTRepository objectFromApplication:@"level.json"];
            XCTAssert([data isKindOfClass:[NSDictionary class]]);
            _levelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:data];
            XCTAssertNotNil(_levelSettings, @"Level Settings object has not been initialized properly!");
        }
        _cell = [[SLTCell alloc] initWithX:6 andY:4];
        XCTAssertNotNil(_cell);
        _compositeInfo = [[SLTCompositeInfo alloc] initWithAssetId:@"2839" stateId:@"534" cell:_cell andLevelSettings:_levelSettings];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCompositeInfoObject
{
    XCTAssertNotNil(_compositeInfo, @"SLTCompositeInfo has not been initialized properly!");
}

- (void)testAssetId
{
    XCTAssertNotNil(_compositeInfo.assetId);
    XCTAssertEqualObjects(_compositeInfo.assetId, @"2839", @"Wrong assetId is specified");
}

- (void)testGenerate
{
    SLTCompositeAsset* asset = [_levelSettings.assetMap objectForKey:@"2839"];
    NSString* state = [_levelSettings.stateMap objectForKey:@"534"];
    XCTAssertNil(_cell.assetInstance, @"Cell instance should not be generated yet");
    [_compositeInfo generate];
    XCTAssertNotNil(_cell.assetInstance, @"The cell asset instance is not generated properly");
    XCTAssert([_cell.assetInstance isKindOfClass:[SLTCompositeInstance class]]);
    XCTAssertEqualObjects(_cell.assetInstance.type, asset.type, @"Wrong type has been specified!");
    XCTAssertEqualObjects(_cell.assetInstance.keys, asset.keys, @"Wrong keys has been specified!");
    XCTAssertEqualObjects(_cell.assetInstance.state, state, @"Wrong state has been specified!");
    XCTAssertEqualObjects(((SLTCompositeInstance*)(_cell.assetInstance)).cells, asset.cellInfos, @"");
}
@end
