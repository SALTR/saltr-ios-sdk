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
#import "SLTRepository.h"

@interface RepositoryTests : XCTestCase

@end

@implementation RepositoryTests

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

- (void)testBundleLoading
{
    NSBundle* libraryBundle = [SLTRepository libraryBundle];
    XCTAssertNotNil(libraryBundle, "Saltr.bundle is not loaded!");
    
}

- (void)testLevelFileExists
{
    NSString* levelJsonPath = [[SLTRepository libraryBundle] pathForResource:@"level" ofType:@"json"];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:levelJsonPath], @"level.json file does not exist");
}

- (void)testAppDataFileExists
{
    NSString* appDataJsonPath = [[SLTRepository libraryBundle] pathForResource:@"appdata" ofType:@"json"];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:appDataJsonPath], @"appdata.json file does not exist");
}

-(void) testObjectVersion {
    XCTAssertTrue(false, @"This case is tested in the test app!");
}

-(void) testObjectFromStorage {
    NSDictionary* data = [SLTRepository objectFromStorage:@"filename"];
    XCTAssertTrue(data, @"There is no data in the storage!");
}

-(void) testObjectFromCache {
    XCTAssertTrue(false, @"This case is tested in the test app!");
}

-(void) cacheObject {
    XCTAssertTrue(false, @"This case is tested in the test app!");
}

@end
