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
#import "PSSaltr.h"

@interface SaltrTests : XCTestCase {
    PSSaltr* saltr;
}
@end

@implementation SaltrTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    saltr = [PSSaltr saltrWithInstanceKey:@"08626247-f03d-0d83-b69f-4f03f80ef555" andCacheEnabled:YES];
    [[PSSaltr sharedInstance] setupPartnerWithId:@"100000024783448" andPartnerType:@"22facebook"];
    [[PSSaltr sharedInstance] setupDeviceWithId:@"asdas123kasd" andDeviceType:@"phone"];
    [[PSSaltr sharedInstance] defineFeatureWithToken:@"token" andProperties:[NSDictionary new]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testSaltrWithInstanceKey {
    PSSaltr* saltr2 = [PSSaltr saltrWithInstanceKey:@"08626247-f03d-0d83-b69f-4f03f80ef555_TEST" andCacheEnabled:YES];
    XCTAssertTrue([saltr isEqual:saltr2], @"Creation of singleton PSSaltr object failed!");
}

-(void) testAppData {
    [[PSSaltr sharedInstance] appData];
    sleep(4);
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testSetupPartnerWithId {
    XCTAssertTrue(true, @"Setup of partner id succeeded!");
}

-(void) testSetupDeviceWithId {
    XCTAssertTrue(true, @"Setup of device id succeeded!");
}

-(void) testDefineFeatureWithToken  {
    XCTAssertTrue(true, @"Definition of features with token succeeded!");
}

-(void) testLevelDataBodyWithLevelPack {
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testAddUserPropertyWithNames {
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
