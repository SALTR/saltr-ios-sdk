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
#import "SLTChunk.h"
#import "SLTLevelSettings.h"
#import "SLTRepository.h"
#import "SLTLevelBoardParser.h"
#import "SLTChunkAssetInfo.h"
#import "SLTCellMatrix.h"
#import "SLTCell.h"
#import "SLTAssetInstance.h"

@interface SLTChunkTests : XCTestCase
{
    SLTChunk* _chunk;
    SLTLevelSettings* _levelSettings;
    SLTAssetInstance* _assetInstance1;
    SLTAssetInstance* _assetInstance2;
    SLTAssetInstance* _weakAssetInstance1;
    SLTAssetInstance* _weakAssetInstance2;
    NSMutableArray* _chunkCells;
}
@end

@implementation SLTChunkTests


- (SLTAssetInstance*)createAssetInstanceWithId:(NSString*)assetId andStateId:(NSString*)stateId
{
    SLTAsset* asset = [_levelSettings.assetMap objectForKey:assetId];
    NSString* state = [_levelSettings.stateMap objectForKey:stateId];
    return [[SLTAssetInstance alloc] initWithState:state type:asset.type andKeys:asset.keys];
}

- (NSMutableArray*)chunkAssetInfos
{
    NSMutableArray* chunkAssetInfos = [[NSMutableArray alloc] init];
    SLTChunkAssetInfo* chunkAssetInfo1 = [[SLTChunkAssetInfo alloc] initWithAssetId:@"2837" count:2 andStateId:@"534"];
    [chunkAssetInfos insertObject:chunkAssetInfo1 atIndex:0];
    _assetInstance1 = [self createAssetInstanceWithId:@"2837" andStateId:@"534"];
    
    SLTChunkAssetInfo* chunkAssetInfo2 = [[SLTChunkAssetInfo alloc] initWithAssetId:@"2838" count:3 andStateId:@"535"];
    [chunkAssetInfos insertObject:chunkAssetInfo2 atIndex:1];
    _assetInstance2 = [self createAssetInstanceWithId:@"2838" andStateId:@"535"];

    SLTChunkAssetInfo* chunkAssetInfoWeak1 = [[SLTChunkAssetInfo alloc] initWithAssetId:@"2835" count:0 andStateId:@"534"];
    [chunkAssetInfos insertObject:chunkAssetInfoWeak1 atIndex:2];
    _weakAssetInstance1 = [self createAssetInstanceWithId:@"2835" andStateId:@"534"];

    SLTChunkAssetInfo* chunkAssetInfoWeak2 = [[SLTChunkAssetInfo alloc] initWithAssetId:@"2836" count:0 andStateId:@""];
    [chunkAssetInfos insertObject:chunkAssetInfoWeak2 atIndex:3];
    _weakAssetInstance2 = [self createAssetInstanceWithId:@"2836" andStateId:@""];
    
    return chunkAssetInfos;
}

- (NSMutableArray*)chunkCells
{
    SLTCellMatrix* cells = [[SLTCellMatrix alloc] initWithWidth:12 andHeight:11];
    XCTAssertNotNil(cells);
    for (NSUInteger i = 0; i < cells.height; ++i) {
        for (NSUInteger j = 0 ; j < cells.width; ++j) {
            SLTCell* cell = [[SLTCell alloc] initWithX:j andY:i];
            assert(cell);
            [cells insertCell:cell atRow:j andColumn:i];
        }
    }
    NSArray* chunkCellNodes = [NSMutableArray arrayWithObjects:@[@9, @5],@[@10, @5],@[@9, @4],@[@10, @4],@[@8, @3],@[@9, @3],@[@10, @3],@[@9, @2],@[@10, @2], nil];
    XCTAssertNotNil(chunkCellNodes);
    _chunkCells = [[NSMutableArray alloc] init];
    XCTAssertNotNil(_chunkCells);
    for (NSUInteger i = 0; i < chunkCellNodes.count; ++i) {
        XCTAssert([[chunkCellNodes objectAtIndex:i] isKindOfClass:[NSArray class]]);
        NSArray* chunkCellNode = [chunkCellNodes objectAtIndex:i];
        XCTAssertNotNil(chunkCellNode);
        NSUInteger xCoord = [[chunkCellNode objectAtIndex:0] integerValue];
        NSUInteger yCoord = [[chunkCellNode objectAtIndex:1] integerValue];
        SLTCell* cell = [cells retrieveCellAtRow:xCoord andColumn:yCoord];
        XCTAssertNotNil(cell);
        [_chunkCells insertObject:cell atIndex:i];
    }
    return _chunkCells;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_levelSettings) {
        SLTRepository* repository = [[SLTRepository alloc] init];
        id data = [repository objectFromStorage:@"level.json"];
        XCTAssert([data isKindOfClass:[NSDictionary class]]);
        _levelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:data];
        XCTAssertNotNil(_levelSettings, @"Level Settings has not been initialized properly!");
    }
    NSMutableArray* cells = [self chunkCells];
    NSMutableArray* cellInfos = [self chunkAssetInfos];
    _chunk = [[SLTChunk alloc] initWithChunkCells:cells andChunkAssetInfos:cellInfos andLevelSettings:_levelSettings];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSLTChunkObject
{
    XCTAssertNotNil(_chunk, @"SLTChunk has not been initialized properly!");
}

- (BOOL) compareCellAssetInstance:(SLTAssetInstance*)cellAssetInstance withAssetInstanceSample:(SLTAssetInstance*)assetInstance
{
   return [cellAssetInstance.keys isEqual:assetInstance.keys] && [cellAssetInstance.type isEqual:assetInstance.type] &&  [cellAssetInstance.state isEqual:assetInstance.state];
}

- (void)validateStrongAssetInstances
{
    NSUInteger counterAssetInstance1 = 0;
    NSUInteger counterAssetInstance2 = 0;

    for (NSUInteger i = 0; i < _chunkCells.count; ++i) {
        SLTCell* cell = [_chunkCells objectAtIndex:i];
        XCTAssertNotNil(cell);
        if ([self compareCellAssetInstance:cell.assetInstance withAssetInstanceSample:_assetInstance1]){
            counterAssetInstance1++;
        }
        if ([self compareCellAssetInstance:cell.assetInstance withAssetInstanceSample:_assetInstance2]) {
            counterAssetInstance2++;
        }
    }
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:counterAssetInstance1], @2, "Count of asset instance 1 should be 2");
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:counterAssetInstance2], @3, "Count of asset instance 2 should be 3");
}

- (void)validateWeakAssetInstances
{
    NSUInteger counterWeakAssetInstance1 = 0;
    NSUInteger counterWeakAssetInstance2 = 0;
    
    for (NSUInteger i = 0; i < _chunkCells.count; ++i) {
        SLTCell* cell = [_chunkCells objectAtIndex:i];
        XCTAssertNotNil(cell);
        if ([self compareCellAssetInstance:cell.assetInstance withAssetInstanceSample:_weakAssetInstance1]){
            counterWeakAssetInstance1++;
        }
        if ([self compareCellAssetInstance:cell.assetInstance withAssetInstanceSample:_weakAssetInstance2]) {
            counterWeakAssetInstance2++;
        }
    }
    NSUInteger weakAssetCount = _chunkCells.count - (3 + 2);
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:(counterWeakAssetInstance1 + counterWeakAssetInstance2)], [NSNumber numberWithUnsignedInteger:weakAssetCount], "Summery count of weak assets should be 4");
}

- (void)testGenerate
{
    [_chunk generate];
    [self validateStrongAssetInstances];
    [self validateWeakAssetInstances];
}

@end
