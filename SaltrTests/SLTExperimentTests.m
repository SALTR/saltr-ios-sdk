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
#import "SLTExperiment.h"

@interface SLTExperimentTests : XCTestCase
{
    SLTExperiment* _experiment;
}
@end

@implementation SLTExperimentTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_experiment) {
        _experiment = [[SLTExperiment alloc] initWithToken:@"EXPERIMENT1" partition:@"A" andType:@"feature"];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPartition
{
    XCTAssertEqualObjects(_experiment.partition, @"A", @"Wrong partition is specified");
}

- (void)testToken
{
    XCTAssertEqualObjects(_experiment.token, @"EXPERIMENT1", @"Wrong token is specified");
}

- (void)testType
{
    XCTAssertEqualObjects(_experiment.type, @"feature", @"Wrong type is specified");
}

@end
