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

@interface SaltrTests : XCTestCase <SaltrRequestDelegate>
{
    
}
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

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

// SaltrRequestDelegate protocol methonds

/// Informs that getting App data request has succeeded
-(void) didFinishGettingAppDataRequest
{
    // TODO: Implement
}

/// Informs that getting app data request has failed
-(void) didFailGettingAppDataRequest:(SLTStatus*)status
{
    // TODO: Implement
}

/// Informs that getting level data body with level pack request has succeeded
-(void) didFinishGettingLevelDataRequest
{
    // TODO: Implement
}

/// Informs that getting level data body with level pack request has failed
-(void) didFailGettingLevelDataRequest:(SLTStatus*)status
{
    // TODO: Implement
}

@end
