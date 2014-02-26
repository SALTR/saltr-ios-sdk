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

@interface SaltrTests : XCTestCase

@end

@implementation SaltrTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testSaltrWithInstanceKey {
    [PSSaltr saltrWithInstanceKey:@"instanceKey" andCacheEnabled:YES];
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);

}

-(void) testAppData {
    [[PSSaltr sharedInstance] appData];
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testSetupPartnerWithId {
    [[PSSaltr sharedInstance] setupPartnerWithId:@"id" andPartnerType:@"type"];
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testSetupDeviceWithId {
    [[PSSaltr sharedInstance] setupDeviceWithId:@"id" andDeviceType:@"type"];
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testDefineFeatureWithToken  {
    [[PSSaltr sharedInstance] defineFeatureWithToken:@"token" andProperties:[NSArray new]];
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testLevelDataBodyWithLevelPack {
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testAddPropertyPropertyWithSaltrUserId {
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
