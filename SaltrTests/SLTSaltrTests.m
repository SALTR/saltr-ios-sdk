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
#import "SLTFeature.h"
#import "SLTExperiment.h"
#import "SLTConfig.h"
#import "SLTError.h"

@interface SaltrTests : XCTestCase <SaltrRequestDelegate>
{
    SLTSaltr* saltr;
    id _testData;
}
@end

///http://saltadmin.includiv.com/static_data/d2066eaf-6206-8975-3bb1-0541f196fa3c/levels/314.json


@implementation SaltrTests

/**
 * a) To test error handling, when appdata response sending fails, you need to configure saltr shared instance accordingly before running testStart unit test:
 *      1. Response data with FAILED status - Please put for example wrong value of instance key or partner.
 *      2. Server unreachable - disconnect from all types of network
 */
- (void)setUp
{
    [super setUp];
   /**  Preparing the request to get the app data from server with the following URL:
    * http://api.saltr.com/httpjson.action?command=APPDATA&arguments=%7B%22instanceKey%22:%2208626247-f03d-0d83-b69f-4f03f80ef555%22,%22partner%22:%7B%22partnerId%22:%22100000024783448%22,%22partnerType%22:%22facebook%22,%22gender%22:%22male%22,%22age%22:36,%22firstName%22:%22Artem%22,%22lastName%22:%22Sukiasyan%22%7D,%22device%22:%7B%22deviceId%22:%22asdas123kasd%22,%22deviceType%22:%22iphone%22%7D%7D
    */
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

-(void) testSaltrWithInstanceKey
{
    SLTSaltr* saltr2 = [SLTSaltr saltrWithInstanceKey:@"08626247-f03d-0d83-b69f-4f03f80ef555_TEST" andCacheEnabled:YES];
    XCTAssertTrue([saltr isEqual:saltr2], @"Creation of singleton SLTSaltr object failed!");
}

-(void) testStart
{
    [[SLTSaltr sharedInstance] start];
}

- (void)testInstanceKey
{
    XCTAssertEqualObjects([SLTSaltr sharedInstance].instanceKey, @"08626247-f03d-0d83-b69f-4f03f80ef555", @"Wrong value is specified for instance key");
}

- (void)testCacheEnabled
{
    XCTAssertTrue([SLTSaltr sharedInstance].enableCache,  @"Wrong value is specified for enableCache!");
}

-(void) testSetupPartnerWithId
{
    XCTAssertTrue(true, @"Setup of partner id succeeded!");
}

-(void) testSetupDeviceWithId
{
    XCTAssertTrue(true, @"Setup of device id succeeded!");
}

-(void) testImportLevels
{
    _testData = [SLTRepository objectFromApplication:LEVEL_PACK_URL_PACKAGE];
    XCTAssertNotNil(_testData);
    [saltr importLevels:LEVEL_PACK_URL_PACKAGE];
    [self validateLevelPacks];
}

-(void) testDefineFeatureWithToken
{
    XCTAssertTrue(true, @"Definition of features with token succeeded!");
}

/** @todo It would be nice to make [[SLTSaltr sharedInstance] loadLevelContentDataFromPackage] function public 
 * to handle the case when user just wants to import level packs and *levels from package. 
 * Now by calling loadLevelContentData:levelStructure:andCacheEnabled function, it sends request to the portal with
 * internal path, then looks the caches, and finally loads from internal package.
 */
-(void) testloadLevelContentDataFromAppStorage
{
    [saltr importLevels:nil];
    SLTLevelPack* pack = [saltr.levelPacks objectAtIndex:0];
    SLTLevel* level = [pack.levels objectAtIndex:0];
    [saltr loadLevelContentData:pack levelStructure:level andCacheEnabled:NO];
    XCTAssertTrue(level.contentReady);
    XCTAssertEqualObjects(level.levelId, @"6125");
    XCTAssertNotNil(level.levelSettings);
    XCTAssertNotNil([level boardWithId:@"board1"]);
}

-(void) testAddUserPropertyWithNames {
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

/// @note before getting feature with token, start method should be called to initialize features list.
-(void)testFeatureForToken {
    [[SLTSaltr sharedInstance] featureForToken:@""];
    XCTAssertTrue(true, @"Feature is successfully obtained!");
}

- (void)validateLevels:(NSArray*)levels withTestLevels:(NSArray*)testLevels
{
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:levels.count], [NSNumber numberWithUnsignedInteger:testLevels.count], @"The count of levels received from server should be equal to test data from sample!");
    for (NSUInteger i = 0;  i < levels.count; ++i) {
        SLTLevel* level = [levels objectAtIndex:i];
        XCTAssertNotNil(level);
        NSDictionary* testLevel = nil;
        for (NSUInteger j = 0; j < testLevels.count; ++j) {
            NSString* order = [[[testLevels objectAtIndex:j] objectForKey:@"order"] stringValue];
            if ([level.index isEqualToString:order]) {
                testLevel = [testLevels objectAtIndex:j];
            }
        }
        XCTAssertNotNil(testLevel, @"server data has been changed comparing to our test appdata.json");
        XCTAssertEqualObjects([testLevel objectForKey:@"id"], level.levelId,  @"");
        XCTAssertEqualObjects([testLevel objectForKey:@"url"], level.contentDataUrl,  @"");
        XCTAssertEqualObjects([[testLevel objectForKey:@"version"] stringValue], level.version,  @"");
        XCTAssertEqualObjects([testLevel objectForKey:@"properties"], level.properties,  @"");
    }
}

- (void)validateLevelPacks
{
    SLTSaltr* saltrInstance = [SLTSaltr  sharedInstance];
    XCTAssertNotNil(saltrInstance);
    NSArray* testLevelPacks = [_testData objectForKey:@"levelPackList"];
    XCTAssertNotNil(testLevelPacks);
    NSArray* levelPacks = saltrInstance.levelPacks;
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:testLevelPacks.count], [NSNumber numberWithUnsignedInteger:levelPacks.count], @"The count of level packs get from server should be equal to test data from sample!");
    for (NSUInteger i = 0;  i < levelPacks.count; ++i) {
        SLTLevelPack* levelPack = [levelPacks objectAtIndex:i];
        XCTAssertNotNil(levelPack);
        NSDictionary* testLevelPack = nil;
        for (NSUInteger j = 0; j < testLevelPacks.count; ++j) {
            NSString* order = [[[testLevelPacks objectAtIndex:j] objectForKey:@"order"] stringValue];
            if ([levelPack.index isEqualToString:order]) {
                testLevelPack = [testLevelPacks objectAtIndex:j];
            }
        }
        XCTAssertNotNil(testLevelPack, @"server data has been changed comparing to our test appdata.json");
        XCTAssertEqualObjects([testLevelPack objectForKey:@"token"], levelPack.token,  @"The token of level pack received from server should be equal with token of level pack from sample test data!");
        [self validateLevels:levelPack.levels withTestLevels:[testLevelPack objectForKey:@"levelList"]];
    }
}

- (void)validateFeatures
{
    SLTSaltr* saltrInstance = [SLTSaltr  sharedInstance];
    XCTAssertNotNil(saltrInstance);
    NSArray* testFeatureList = [_testData objectForKey:@"featureList"];
    XCTAssertNotNil(testFeatureList);
    NSMutableDictionary* features = saltrInstance.features;
    XCTAssertNotNil(features);
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:testFeatureList.count], [NSNumber numberWithUnsignedInteger:features.count], @"The count of features received from server should be equal to test data from sample!");
    for (NSUInteger i = 0 ; i < testFeatureList.count; ++i) {
        NSMutableDictionary* testFeature = [testFeatureList objectAtIndex:i];
        XCTAssertNotNil(testFeatureList);
        NSString* token = [testFeature objectForKey:@"token"];
        XCTAssertNotNil(token);
        SLTFeature* feature =  [features objectForKey:token];
        XCTAssertNotNil(feature);
        XCTAssertEqualObjects([testFeature objectForKey:@"data"], feature.properties, @"The data of feature received from server should be equal with data of feature from sample test data!");
    }
}

- (void)validateExperiments
{
    SLTSaltr* saltrInstance = [SLTSaltr  sharedInstance];
    XCTAssertNotNil(saltrInstance);
    NSArray* testExperiments = [_testData objectForKey:@"splitTestInfo"];
    XCTAssertNotNil(testExperiments);
    NSArray* experiments = saltrInstance.experiments;
    XCTAssertNotNil(experiments);
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:testExperiments.count], [NSNumber numberWithUnsignedInteger:experiments.count], @"The count of splitTestInfos received from server should be equal to test data from sample!");
    for (NSUInteger i = 0 ; i < testExperiments.count; ++i) {
        NSDictionary* testExperiment = [testExperiments objectAtIndex:i];
        XCTAssertNotNil(testExperiment);
        SLTExperiment* experiment = [experiments objectAtIndex:i];
        XCTAssertNotNil(experiment);
        XCTAssertEqualObjects([testExperiment objectForKey:@"token"], experiment.token, @"The token of experiment received from server should be equal with token of experiment from sample test data!");
        XCTAssertEqualObjects([testExperiment objectForKey:@"partitionName"], experiment.partition, @"The partitionName of experiment received from server should be equal with partitionName of experiment from sample test data!");
        XCTAssertEqualObjects([testExperiment objectForKey:@"type"], experiment.type, @"The type of experiment received from server should be equal with type of experiment from sample test data!");
    }
}

#pragma mark @b SaltrRequestDelegate protocol methods
-(void) didFinishGettingAppDataRequest
{
    XCTAssertNotNil([[SLTSaltr sharedInstance] levelPacks], @"If getting of level pack data succeeded, level pack info should be loaded!");
    NSDictionary* testAppData = [SLTRepository objectFromApplication:@"appdata.json"];
    XCTAssertNotNil(testAppData);
    _testData = [testAppData objectForKey:@"responseData"];
    XCTAssertNotNil(_testData);
    [self validateLevelPacks];
    [self validateFeatures];
    [self validateExperiments];
}

-(void) didFailGettingAppDataRequest:(SLTError*)error
{
    XCTAssertNotNil(error, @"Error should be specified");
    NSLog(@"ERROR CODE = %i, MESSAGE = %@", error.code, error.message);
    XCTAssert((0 == [SLTSaltr sharedInstance].levelPacks.count), @"If getting of level pack data failed, there should not be loaded any level pack info!");
    [self testImportLevels];
}

-(void) didFinishGettingLevelDataBodyWithLevelPackRequest
{
    XCTAssertTrue(TRUE, @"Getting of level data body failed!");
}

-(void) didFailGettingLevelDataBodyWithLevelPackRequest
{
    XCTAssertTrue(false, @"Getting of level data body failed!");
}

@end
