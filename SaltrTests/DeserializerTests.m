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
#import "PSDeserializer.h"
#import "PSRepository.h"

@interface DeserializerTests : XCTestCase {
    PSDeserializer* _deserializer;
}

@end

@implementation DeserializerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_deserializer) {
        _deserializer = [PSDeserializer new];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testDecodeExperimentsFromData
{
    NSString* jsonPath = [[PSRepository libraryBundle] pathForResource:@"appdata" ofType:@"json"];
    NSError* error = nil;
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    if (data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:jsonPath], @"Error while parsing json file to dictionary");
        }
        NSArray* decodedExperiments = [_deserializer decodeExperimentsFromData:dictionary];
        XCTAssertTrue(decodedExperiments, @"Decoding of experiments failed!");
        
    }
}

- (void)testDecodeLevelsFromData
{
    NSString* jsonPath = [[PSRepository libraryBundle] pathForResource:@"appdata" ofType:@"json"];
    NSError* error = nil;
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    if (data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSDictionary* responseData = [dictionary objectForKey:@"responseData"];
        if (error) {
            XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:jsonPath], @"Error while parsing json file to dictionary");
        }
        NSArray* decodedLevelData = [_deserializer decodeLevelsFromData:responseData];
        XCTAssertTrue(decodedLevelData, @"Decoding of level data failed!");
    }
}

- (void)testDecodeFeaturesFromData
{
    NSString* jsonPath = [[PSRepository libraryBundle] pathForResource:@"appdata" ofType:@"json"];
    NSError* error = nil;
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    if (data) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:jsonPath], @"Error while parsing json file to dictionary");
        }
        NSDictionary* decodedFeatures = [_deserializer decodeFeaturesFromData:dictionary];
        XCTAssertTrue(decodedFeatures, @"Decoding of features failed!");
    }
}

@end
