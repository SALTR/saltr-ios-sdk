//
//  SaltrTests.m
//  SaltrTests
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

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
