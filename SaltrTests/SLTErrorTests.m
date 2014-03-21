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
#import "SLTError.h"

@interface SLTErrorTests : XCTestCase
{
    SLTError* _error;
}
@end

@implementation SLTErrorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_error) {
        _error = [[SLTError alloc] initWithCode:GENERAL_ERROR_CODE andMessage:@"Could not connect to SALTR"];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCode
{
    XCTAssertEqual(_error.code, GENERAL_ERROR_CODE, @"Wrong code is specified");
}

- (void)testMessage
{
    XCTAssertEqualObjects(_error.message, @"Could not connect to SALTR", @"Wrong message is specified");
}

@end
