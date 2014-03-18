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
#import "SLTCompositeAsset.h"

@interface SLTCompositeAssetTests : XCTestCase
{
    SLTCompositeAsset* _compositeAsset;
    NSMutableArray* _cellInfoData;
    NSDictionary* _keysData;
}

@end

@implementation SLTCompositeAssetTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_compositeAsset) {
        _keysData = @{
                      @"CARD_VALUE": [NSNumber numberWithInt:13],
                      @"CARD_SUIT": [NSNumber numberWithInt:2],
                      @"COLOR": [NSNumber numberWithInt:9],
                      };
       _cellInfoData = [NSMutableArray arrayWithObjects:@[@0, @0], @[@6, @0], @[@6, @1], nil];
        XCTAssert(_cellInfoData);
        _compositeAsset = [[SLTCompositeAsset alloc] initWithCellInfos:_cellInfoData type:@"composite_asset" andKeys:_keysData];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCompositeAssetObject
{
    XCTAssertNotNil(_compositeAsset, @"SLTCompositeAsset has not been initialized properly!");
}

- (void)testCellInfos
{
    XCTAssertNotNil(_compositeAsset.cellInfos, @"Composite assets infos has not been initialized properly!");
    NSArray* cellInfos = _compositeAsset.cellInfos;
    NSArray* cell0 = [_cellInfoData objectAtIndex:0];
    XCTAssertEqualObjects([cellInfos objectAtIndex:0], cell0, @"Wrong cell is specified");
    NSArray* cell1 = [_cellInfoData objectAtIndex:1];
    XCTAssertEqualObjects([cellInfos objectAtIndex:1], cell1, @"Wrong cell is specified");
    NSArray* cell2 = [_cellInfoData objectAtIndex:2];
    XCTAssertEqualObjects([cellInfos objectAtIndex:(cellInfos.count - 1)], cell2, @"Wrong cell is specified");
}

- (void)testType
{
    XCTAssertEqualObjects(_compositeAsset.type, @"composite_asset", @"Wrong type has been specified!");
}

- (void)testKeys
{
    XCTAssertEqualObjects(_compositeAsset.keys, _keysData, @"Wrong keys have been specified!");
}

@end
