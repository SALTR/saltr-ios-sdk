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
#import "SLTDevice.h"

@interface SLTDeviceTests : XCTestCase
{
    SLTDevice* _device;
}

@end

@implementation SLTDeviceTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_device) {
        _device = [[SLTDevice alloc] initWithDeviceId:@"asdas123kasd" andDeviceType:@"phone"];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTDeviceObject
{
    XCTAssertNotNil(_device, @"SLTDevice object has not been initialized properly!");
}

- (void)testDeviceId
{
    XCTAssertEqualObjects(_device.deviceId, @"asdas123kasd", @"Wrong device Id is specified");
}

- (void)testDeviceType
{
    XCTAssertEqualObjects(_device.deviceType, @"phone", @"Wrong device type is specified");
    
}

-(void)testToDictionary
{
    NSString* deviceId = @"asdas123kasd";
    NSString* deviceType = @"phone";
    NSDictionary* device = [NSDictionary dictionaryWithObjectsAndKeys:deviceId, @"deviceId", deviceType, @"deviceType", nil];
    XCTAssertEqualObjects([_device toDictionary], device, @"Wrong device Id or partner type is specified");
}

@end
