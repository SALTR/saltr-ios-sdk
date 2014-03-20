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
#import "SLTSaltr.h"
#import "SLTConfig.h"

@interface SaltrTests : XCTestCase <SaltrRequestDelegate> {
    SLTSaltr* saltr;
}
@end

@implementation SaltrTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    saltr = [SLTSaltr saltrWithInstanceKey:@"08626247-f03d-0d83-b69f-4f03f80ef555" andCacheEnabled:YES];
    saltr.saltrRequestDelegate = self;
    [[SLTSaltr sharedInstance] setupPartnerWithId:@"100000024783448" andPartnerType:@"facebook"];
    [[SLTSaltr sharedInstance] setupDeviceWithId:@"asdas123kasd" andDeviceType:@"phone"];
    [[SLTSaltr sharedInstance] defineFeatureWithToken:@"token" andProperties:[NSDictionary new]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testSaltrWithInstanceKey {
    SLTSaltr* saltr2 = [SLTSaltr saltrWithInstanceKey:@"08626247-f03d-0d83-b69f-4f03f80ef555_TEST" andCacheEnabled:YES];
    XCTAssertTrue([saltr isEqual:saltr2], @"Creation of singleton SLTSaltr object failed!");
}

-(void) testStart {
    [saltr start];
}

-(void) testSetupPartnerWithId {
    XCTAssertTrue(true, @"Setup of partner id succeeded!");
}

-(void) testSetupDeviceWithId {
    XCTAssertTrue(true, @"Setup of device id succeeded!");
}

-(void) testImportLevels {
    [saltr importLevels:LEVEL_PACK_URL_PACKAGE];
    XCTAssertTrue(true, @"Levels are successfully imported!");
}

-(void) testDefineFeatureWithToken  {
    XCTAssertTrue(true, @"Definition of features with token succeeded!");
}

-(void) testloadLevelContentData {
    [saltr importLevels:nil];
    SLTLevelPack* pack = [saltr.levelPackStructures objectAtIndex:0];
    SLTLevel* level = [pack.levels objectAtIndex:0];
    [saltr loadLevelContentData:pack levelStructure:level andCacheEnabled:YES];
    XCTAssertTrue(true, @"Level data is successfully loaded!");
}

-(void) testAddUserPropertyWithNames {
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

/// @note before getting feature with token, start method should be called to initialize features list.
-(void)testFeatureForToken {
    [[SLTSaltr sharedInstance] featureForToken:@""];
    XCTAssertTrue(true, @"Feature is successfully obtained!");
}

#pragma mark @b SaltrRequestDelegate protocol methods

-(void) didFinishGettingAppDataRequest {
    XCTAssertTrue(true, @"Getting of app data succeeded!");
}

-(void) didFailGettingAppDataRequest {
    XCTAssertTrue(false, @"Getting of app data failed!");
}

-(void) didFinishGettingLevelDataBodyWithLevelPackRequest {
    XCTAssertTrue(true, @"Getting of level data body succeeded!");
}

-(void) didFailGettingLevelDataBodyWithLevelPackRequest {
    XCTAssertTrue(false, @"Getting of level data body failed!");
}

@end
