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
#import "SLTPartner.h"

@interface SLTPartnerTests : XCTestCase
{
    SLTPartner* _partner;
}
@end

@implementation SLTPartnerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_partner) {
        _partner = [[SLTPartner alloc] initWithPartnerId:@"100000024783448" andPartnerType:@"facebook"];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTPartnerObject
{
    XCTAssertNotNil(_partner, @"SLTPartner object has not been initialized properly!");
}

- (void)testPartnerId
{
    XCTAssertEqualObjects(_partner.partnerId, @"100000024783448", @"Wrong partner Id is specified");
}

- (void)testPartnerType
{
    XCTAssertEqualObjects(_partner.partnerType, @"facebook", @"Wrong partner type is specified");

}

-(void)testToDictionary
{
    NSString* partnerId = @"100000024783448";
    NSString* partnerType = @"facebook";
    NSDictionary* partner = [NSDictionary dictionaryWithObjectsAndKeys:partnerId, @"partnerId", partnerType, @"partnerType", nil];
    XCTAssertEqualObjects([_partner toDictionary], partner, @"Wrong partner Id or partner type is specified");
}

@end
