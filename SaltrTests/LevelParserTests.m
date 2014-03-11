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
#import "PSRepository.h"
#import "PSLevelParser.h"
#import "PSLevelStructure.h"
#import "PSLevelBoard.h"
#import "PSVector2D.h"
#import "PSVector2DIterator.h"
#import "SLTAsset.h"
#import "SLTAssetInstance.h"
#import "PSCompositeInstance.h"
#import "SLTCell.h"

@interface LevelParserTests : XCTestCase

@end

@implementation LevelParserTests

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

- (void)testLevelParsing
{
    PSRepository* repository = [[PSRepository alloc] init];
    id data = [repository objectFromStorage:@"level.json"];
    PSLevelStructure* level = [[PSLevelStructure alloc] init];
    [[PSLevelParser sharedInstance] parseData:data andFillLevelStructure:level];
    NSLog(@"BOARD DATA %@", level);
    PSLevelBoard* levelBoard = [level.boards objectForKey:@"board1"];
    NSLog(@"LEVEL BOARD : %@", levelBoard);
    PSVector2D* vectorBoard = levelBoard.boardVector;
    NSLog(@"LEVEL BOARD Vector : %@", vectorBoard);
    PSVector2DIterator* iterator = [vectorBoard iterator];
    SLTCell* cell = [vectorBoard retrieveObjectAtRow:0 andColumn:0];
    assert(iterator);
    while ([iterator hasNext]) {
        cell = [iterator nextObject];
        NSLog(@"PRINT   %@:", cell);
        assert(cell);
    }
    NSLog(@"LEVEL BOARD properties : %@", [levelBoard boardProperties]);
}

@end
