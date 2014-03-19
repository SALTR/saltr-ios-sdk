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
#import "SLTLevelBoardParser.h"
#import "SLTLevel.h"
#import "SLTLevelBoard.h"
#import "SLTCellMatrix.h"
#import "SLTCellMatrixIterator.h"
#import "SLTCell.h"
#import "SLTCompositeAsset.h"
#import "SLTLevelSettings.h"
#import "SLTAssetInstance.h"
#import "SLTCompositeInstance.h"

@interface SLTLevelBoardParserTests : XCTestCase
{
    id _data;
    SLTLevelSettings* _levelSettings;
    NSMutableArray* _resultsData;
    
}
@end

@implementation SLTLevelBoardParserTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_levelSettings) {
        _data= [SLTRepository objectFromApplication:@"level.json"];
        assert([_data isKindOfClass:[NSDictionary class]]);
        _levelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:_data];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

# pragma mark - Level Board Parsing
- (void)testLevelSettingsParsing
{
    SLTLevelSettings* levelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:_data];
    XCTAssertNotNil(levelSettings, @"Level settings have not been initialized properly!");
    [self testAssetMapParsing];
    [self testKeySetMapParsing];
    [self testStateMapParsing];
}

- (void)testAssetMapParsing
{
    NSDictionary* assetsMap = [_levelSettings assetMap];
    XCTAssertNotNil(assetsMap, @"Asset map is not created properly!");
    for (NSString* key in assetsMap) {
        id asset = [assetsMap objectForKey:key];
        XCTAssertNotNil(asset, @"Asset is not created properly!");
        XCTAssert([asset isKindOfClass:[SLTAsset class]]);
        if ([asset isKindOfClass:[SLTCompositeAsset class]]) {
            [self validateCompositeAsset:asset withKey:key];
        } else {
            [self validateAsset:asset withKey:key];
        }
    }
}

- (void)testKeySetMapParsing
{
    NSDictionary* keySet = _levelSettings.keySetMap;
    NSDictionary* colorKey = [keySet objectForKey:@"COLOR"];
    XCTAssert([colorKey isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([colorKey objectForKey:@"1"], @"white", @"The value of key=1 should be 'white'!");
    XCTAssertEqualObjects([colorKey objectForKey:@"8"], @"magenta", @"The value of key=8 should be 'magenta'!");
    XCTAssertEqualObjects([colorKey objectForKey:@"13"], @"brown", @"The value of key=13 should be 'brown'!");
    
    NSDictionary*  cardSuitKey= [keySet objectForKey:@"CARD_SUIT"];
    XCTAssert([cardSuitKey isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"1"], @"spade", @"The value of key=1 should be 'spade'!");
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"2"], @"club", @"The value of key=2 should be 'club'!");
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"3"], @"heart", @"The value of key=3 should be 'heart'!");
    XCTAssertEqualObjects([cardSuitKey objectForKey:@"4"], @"diamond", @"The value of key=4 should be 'diamond'!");
    
    NSDictionary*  cardValueKey = [keySet objectForKey:@"CARD_VALUE"];
    XCTAssert([cardValueKey isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([cardValueKey objectForKey:@"1"], @"2", @"The value of key=1 should be '2'!");
    XCTAssertEqualObjects([cardValueKey objectForKey:@"9"], @"10", @"The value of key=9 should be '10'!");
    XCTAssertEqualObjects([cardValueKey objectForKey:@"10"], @"ace", @"The value of key=10 should be 'ace'!");
    XCTAssertEqualObjects([cardValueKey objectForKey:@"13"], @"king", @"The value of key=13 should be 'king'!");
}

- (void)testStateMapParsing
{
    NSDictionary* stateMap = _levelSettings.stateMap;
    XCTAssertEqualObjects([stateMap objectForKey:@"534"], @"state1", @"The value of state with Id = 534 should be 'state1'!");
    XCTAssertEqualObjects([stateMap objectForKey:@"535"], @"state2", @"The value of state with Id = 535 should be 'state2'!");
}

- (void)validateCompositeAsset:(SLTCompositeAsset*)compositeAsset withKey:(NSString*)key
{
    XCTAssertNotNil(compositeAsset.cellInfos, @"The shift cells should be specified for composite asset");
    NSArray* cellInfos = compositeAsset.cellInfos;
    NSArray* cell0 = @[@0, @0];
    XCTAssertEqualObjects([cellInfos objectAtIndex:0], cell0, @"Wrong shift cell is specified");
    NSArray* cell6 = @[@6, @0];
    XCTAssertEqualObjects([cellInfos objectAtIndex:6], cell6, @"Wrong shift cell is specified");
    NSArray* cell13 = @[@6, @1];
    XCTAssertEqualObjects([cellInfos objectAtIndex:13], cell13, @"Wrong shift cell is specified");
    NSArray* cellLast = @[@6, @6];
    XCTAssertEqualObjects([cellInfos objectAtIndex:(cellInfos.count - 1)], cellLast, @"Wrong shift cell is specified");
    
    [self validateAsset:compositeAsset withKey:key type:@"composite_asset" keys:@{@"COLOR": @3,
                                                                              @"CARD_SUIT":  @2,
                                                                              @"CARD_VALUE":  @3}];
}

- (void)validateAsset:(SLTAsset*)asset withKey:(NSString*)key type:(NSString*)type keys:(NSDictionary*)keys
{
    XCTAssertNotNil(asset, @"Asset should be not nil");
    XCTAssertEqualObjects(asset.type, type, @"Wrong type specified.");
    XCTAssertEqualObjects(asset.keys, keys, @"Wrong keys specified.");
}

- (void)validateAsset:(SLTAsset*)asset withKey:(NSString*)key
{
    NSDictionary* assetKeys = [asset keys];
    XCTAssert([assetKeys isKindOfClass:[NSDictionary class]]);
    XCTAssertNotNil(assetKeys, @"Asset keys are not created properly!");
    switch ([key integerValue]) {
        case 2835: {
            [self validateAsset:asset withKey:key type:@"normal" keys:@{@"COLOR": @1,
                                                                    @"CARD_SUIT":  @1,
                                                                    @"CARD_VALUE":  @1}];
            break;
        } case 2836: {
            [self validateAsset:asset withKey:key type:@"normal" keys:@{@"COLOR": @3,
                                                                    @"CARD_SUIT":  @3,
                                                                    @"CARD_VALUE":  @3}];
            break;
        } case 2837: {
            [self validateAsset:asset withKey:key type:@"normal" keys:@{@"COLOR": @9,
                                                                    @"CARD_SUIT":  @2,
                                                                    @"CARD_VALUE":  @13}];
            break;
        } case 2838: {
            [self validateAsset:asset withKey:key type:@"custom_asset" keys:@{@"COLOR": @11,
                                                                          @"CARD_SUIT":  @4,
                                                                          @"CARD_VALUE":  @8}];
            break;
        } default: {
            break;
        }
    }
}

# pragma mark - private functions to validate level board parsing

- (void)validateCellProperties:(SLTCell*)cell withCellPropertiesNode:(NSArray*)cellNode
{
    XCTAssertNotNil(cellNode);
    XCTAssertNotNil(cell);
    for (NSUInteger i = 0; i < cellNode.count; ++i) {
        NSDictionary* cellProperty = [cellNode objectAtIndex:i];
        XCTAssertNotNil(cellProperty);
        NSArray* coords = [cellProperty objectForKey:@"coords"];
        XCTAssertNotNil(coords);
        if ([coords isEqual:@[@(cell.x), @(cell.y)]]) {
            XCTAssertEqualObjects([cellProperty objectForKey:@"value"], cell.properties, @"Wrong properties are specified for cell!");
        }
    }
}

- (void)validateBlockedCell:(SLTCell*)cell withBlockedCellsNode:(NSArray*)blockedCellsNode
{
    XCTAssertNotNil(blockedCellsNode);
    XCTAssertNotNil(cell);
    for (NSUInteger i = 0; i < blockedCellsNode.count; ++i) {
        NSArray* blockedCell = [blockedCellsNode objectAtIndex:i];
        XCTAssertNotNil(blockedCell);
        if ([blockedCell isEqual:@[@(cell.x), @(cell.y)]]) {
            XCTAssertTrue(cell.isBlocked, @"Cell should be blocked!");
        }
    }
}

- (void)validateAssetStates:(NSArray*)assetNodeStates forAssetInstance:(SLTAssetInstance*)assetInstance
{
    NSString* assetState = assetInstance.state;
    if (!assetState) {
        return;
    }
    XCTAssertNotNil(assetInstance);
    XCTAssert(assetNodeStates, @"There should be at least one state for asset in JSON");
    NSMutableArray* assetStates = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < assetNodeStates.count; ++i) {
        NSString* stateId = [[assetNodeStates objectAtIndex:i] stringValue];
        XCTAssertNotNil(stateId);
        NSString* state = [_levelSettings.stateMap objectForKey:stateId];
        XCTAssertNotNil(state);
        [assetStates insertObject:state atIndex:i];
    }
    XCTAssertTrue([assetStates containsObject:assetState], @"Asset state should be in the state list of asset in JSON!");
}

- (void)validateCellCompositeInstance:(SLTCell*)cell withBoardNode:(NSDictionary*)boardNode
{
    XCTAssertNotNil(boardNode);
    XCTAssertNotNil(cell);
    NSArray* compositesNodes = [boardNode objectForKey:@"composites"];
    XCTAssertNotNil(compositesNodes);
    XCTAssert([cell.assetInstance isKindOfClass:[SLTCompositeInstance class]]);
    SLTCompositeInstance* compositeInstance = (SLTCompositeInstance*)cell.assetInstance;
    NSUInteger compositesCount = 0;
    for (NSUInteger i = 0; i < compositesNodes.count; ++i) {
        NSDictionary* compositeNode = [compositesNodes objectAtIndex:i];
        XCTAssertNotNil(compositeNode);
         if ([[compositeNode objectForKey:@"position"] isEqual:@[@(cell.x), @(cell.y)]]) {
             compositesCount++;
             for (NSString* assetId in _levelSettings.assetMap) {
                 SLTCompositeAsset* compositeAssetInfo = nil;
                 if ([[_levelSettings.assetMap objectForKey:assetId] isKindOfClass:[SLTCompositeAsset class]]) {
                     compositeAssetInfo = [_levelSettings.assetMap objectForKey:assetId];
                 }
                 if (compositeAssetInfo && ([compositeAssetInfo.keys isEqual:compositeInstance.keys]) &&
                     ([compositeAssetInfo.type isEqual:compositeInstance.type])) {
                     XCTAssertEqualObjects(compositeAssetInfo.cellInfos, compositeInstance.cells, @"Cells should be equal to the list of composite asset cells of JSON!");
                     NSArray* assetNodeStates = nil;
                     NSDictionary* allAssets = [_data objectForKey:@"assets"];
                     for (NSString* key in allAssets) {
                         if ([key isEqualToString:assetId]) {
                             assetNodeStates = [[allAssets objectForKey:key] objectForKey:@"states"];
                         }
                     }
                     [self validateAssetStates:assetNodeStates forAssetInstance:compositeInstance];
                 }
             }
         }
        XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:compositesCount], @1, @"There should be at least one composite asset!");
    }
}

- (void)validateCellAssetInstance:(SLTCell*)cell withBoardNode:(NSDictionary*)boardNode
{
    XCTAssertNotNil(boardNode);
    XCTAssertNotNil(cell);
    NSArray* chunksNodes = [boardNode objectForKey:@"chunks"];
    XCTAssertNotNil(chunksNodes);
    XCTAssertNotNil(cell.assetInstance);
    for (NSUInteger i = 0; i < chunksNodes.count; ++i) {
        NSDictionary* chunkNode = [chunksNodes objectAtIndex:i];
        XCTAssertNotNil(chunkNode);
        NSString* chunkId = [chunkNode objectForKey:@"chunkId"];
        XCTAssertNotNil(chunkId);
        NSArray* chunkCells = [chunkNode objectForKey:@"cells"];
        XCTAssertNotNil(chunkCells);
        if ([chunkCells containsObject:@[@(cell.x), @(cell.y)]]) {
            NSDictionary* chunkAssets = [chunkNode objectForKey:@"assets"];
            XCTAssertNotNil(chunkAssets);
            for (NSDictionary* chunkAsset in chunkAssets) {
                NSString* assetId = [chunkAsset objectForKey:@"assetId"];
                XCTAssertNotNil(assetId);
                SLTAsset* chunkAssetInfo = [_levelSettings.assetMap objectForKey:assetId];
                XCTAssertNotNil(chunkAssetInfo);
                XCTAssertFalse([chunkAssetInfo isKindOfClass:[SLTCompositeAsset class]]);
                if (([chunkAssetInfo.keys isEqual:cell.assetInstance.keys]) &&
                    ([chunkAssetInfo.type isEqual:cell.assetInstance.type])) {
                    NSArray* assetNodeStates = nil;
                    NSDictionary* allAssets = [_data objectForKey:@"assets"];
                    for (NSString* key in allAssets) {
                        if ([key isEqualToString:assetId]) {
                            assetNodeStates = [[allAssets objectForKey:key] objectForKey:@"states"];
                        }
                    }
                    [self validateAssetStates:assetNodeStates forAssetInstance:cell.assetInstance];
                    [_resultsData addObject:@{@"chunkId" : chunkId, @"assetId" : assetId, @"count": [chunkAsset objectForKey:@"count"]}];
                }
            }
        }
    }
}

- (void)validateCellInstance:(SLTCell*)cell withBoardNode:(NSDictionary*)boardNode
{
    XCTAssertNotNil(boardNode);
    if (cell.assetInstance && [cell.assetInstance isKindOfClass:[SLTCompositeInstance class]]) {
        [self validateCellCompositeInstance:cell withBoardNode:boardNode];
    } else if (cell.assetInstance && [cell.assetInstance isKindOfClass:[SLTAssetInstance class]]) {
        [self validateCellAssetInstance:cell withBoardNode:boardNode];
    } else {
        XCTAssertFalse(cell.assetInstance, @"There should not be created asset instance for cell");
    }
}

- (void)setupResultDataWithCapacity:(NSUInteger)capacity
{
    XCTAssert(capacity >= 0);
    if (!_resultsData) {
        _resultsData = [[NSMutableArray alloc] initWithCapacity:capacity];
    } else {
        [_resultsData removeAllObjects];
    }
}

///@TODO This function only collects generated chunk assets in array and print out it.
/// It would be nice to have also validation function, which will check whether the count of generated chunks is correct.
- (void)validateBoardMatrix:(SLTCellMatrix*)cells withBoardNode:(NSDictionary*)boardNode
{
    SLTCellMatrixIterator* iterator = [cells iterator];
    XCTAssertNotNil(iterator);
    [self setupResultDataWithCapacity:(cells.width * cells.height)];
    SLTCell* cell = [cells retrieveCellAtRow:0 andColumn:0];
    while ([iterator hasNext]) {
        XCTAssertNotNil(cell);
        [self validateCellProperties:cell withCellPropertiesNode:[[boardNode objectForKey:@"properties"] objectForKey:@"cell"]];
        [self validateBlockedCell:cell withBlockedCellsNode:[boardNode objectForKey:@"blockedCells"]];
        [self validateCellInstance:cell withBoardNode:boardNode];
        cell = [iterator next];
    }
    for (NSUInteger i = 0; i < _resultsData.count; ++i) {
        NSLog(@"MATRIX of BOARD ==== GENERATED ASSET:  %@", [_resultsData objectAtIndex:i]);
    }
}

- (void)validateBoard:(SLTLevelBoard*)board withBoardNode:(NSDictionary*)boardNode
{
    NSLog(@"NEW BOARD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    XCTAssertNotNil(board, @"Parsed level board has not been initialized properly!");
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:board.cols], [NSNumber numberWithUnsignedInteger:[[boardNode objectForKey:@"cols"] integerValue]], @"Incorrect columns count!");
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:board.rows], [NSNumber numberWithUnsignedInteger:[[boardNode objectForKey:@"rows"] integerValue]], @"Incorrect rows count!");
    XCTAssertEqualObjects(board.properties, [[boardNode objectForKey:@"properties"] objectForKey:@"board"], @"Incorrect board properties!");
    [self validateBoardMatrix:board.cells withBoardNode:boardNode];
}

# pragma mark - Level Board Parsing
- (void)testLevelBoardParsing
{
    NSDictionary* boardNode =  [[_data objectForKey:@"boards"] objectForKey:@"board2"];
    XCTAssertNotNil(boardNode, @"Level board has not been initialized properly!");
    SLTLevelBoard* parsedBoard = [[SLTLevelBoardParser sharedInstance] parseLevelBoard:boardNode withLevelSettings:_levelSettings];
    XCTAssertNotNil(parsedBoard, @"Parsed level board has not been initialized properly!");
    [self validateBoard:parsedBoard withBoardNode:boardNode];
}

# pragma mark - Level Boards Parsing
- (void)testLevelBoardsParsing
{
    NSDictionary* boardNodes =  [_data objectForKey:@"boards"];
    XCTAssertNotNil(boardNodes, @"Level board has not been initialized properly!");
    NSMutableDictionary* boards = [[SLTLevelBoardParser sharedInstance] parseLevelBoards:boardNodes withLevelSettings:_levelSettings];
    XCTAssertNotNil(boards, @"Parsed boards have not been created properly!");
    for (NSString* key in boards) {
        XCTAssertNotNil(key, @"Parsed boards key is not created properly!");
        SLTLevelBoard* board = [boards objectForKey:key];
        XCTAssertNotNil(board, @"Parsed boards key is not created properly!");
        [self validateBoard:board withBoardNode:[boardNodes objectForKey:key]];
    }
}

@end
