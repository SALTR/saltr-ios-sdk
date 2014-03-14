/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevelBoardParser.h"
#import "SLTCellMatrix.h"
#import "SLTLevelSettings.h"
#import "SLTLevel.h"
#import "SLTLevelBoard.h"
#import "SLTCompositeAsset.h"
#import "SLTCompositeInfo.h"
#import "SLTCell_Private.h"
#import "SLTChunk.h"
#import "SLTChunkAssetInfo.h"

@implementation SLTLevelBoardParser {
}

- (id)initUniqueInstance
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[super alloc] initUniqueInstance];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (SLTAsset*)parseAsset:(NSDictionary*)asset
{
    assert(nil != asset);
    NSArray* assetCells = [asset objectForKey:@"cells"];
    NSString* theType = [asset objectForKey:@"type_key"];
    NSDictionary* theKeys = [asset objectForKey:@"keys"];
    if (assetCells) {
        return [[SLTCompositeAsset alloc] initWithCellInfos:assetCells type:theType andKeys:theKeys];
    }
    return [[SLTAsset alloc] initWithType:theType andKeys:theKeys];
}

- (NSDictionary*)parseBoardAssets:(NSDictionary*)assets
{
    assert(nil != assets);
    NSMutableDictionary* assetsMap = [[NSMutableDictionary alloc] init];
    for (NSString* key in assets) {
        NSDictionary* asset = [assets objectForKey:key];
        assert(nil != asset);
        SLTAsset* assetObject = [self parseAsset:asset];
        assert(nil != assetObject);
        [assetsMap setObject:assetObject forKey:key];
    }
    return assetsMap;
}

- (SLTLevelSettings*)parseLevelSettings:(NSDictionary*)rootNode
{
    assert(rootNode);
    id keySetMap = [rootNode objectForKey:@"keySets"];
    assert([keySetMap isKindOfClass:[NSDictionary class]]);
    id assetMap = [self parseBoardAssets:[rootNode objectForKey:@"assets"]];
    assert([assetMap isKindOfClass:[NSDictionary class]]);
    id stateMap = [rootNode objectForKey:@"assetStates"];
    assert([stateMap isKindOfClass:[NSDictionary class]]);
    return [[SLTLevelSettings alloc] initWithAssetMap:assetMap keySetMap:keySetMap andStateMap:stateMap];
}

- (NSDictionary*) parseComposites:(NSArray*)compositeNodes withLevelSettings:(SLTLevelSettings *)levelSettings forCells:(SLTCellMatrix*)cells
{
    assert(levelSettings);
    assert(compositeNodes);
    assert(cells);
    NSMutableDictionary* compositesMap = [[NSMutableDictionary alloc] init];
    for (NSUInteger i = 0; i < compositeNodes.count; ++i) {
        NSDictionary* compositeNode = [compositeNodes objectAtIndex:i];
        assert([[compositeNode objectForKey:@"assetId"] isKindOfClass:[NSNumber class]]);
        NSString* assetId = [[compositeNode objectForKey:@"assetId"] stringValue];
        assert(assetId);
        NSString* stateId = [[compositeNode objectForKey:@"stateId"] stringValue];
        /// Supporting position(old) and cell.
        NSArray* compositePosition = [compositeNode objectForKey:@"cell"] ? [compositeNode objectForKey:@"cell"] : [compositeNode objectForKey:@"position"];
        NSUInteger xCoord = [[compositePosition objectAtIndex:0] integerValue];
        NSUInteger yCoord = [[compositePosition objectAtIndex:1] integerValue];
        SLTCell* cell = [cells retrieveCellAtRow:xCoord andColumn:yCoord];
        SLTCompositeInfo* composite = [[SLTCompositeInfo alloc] initWithAssetId:assetId stateId:stateId cell:cell andLevelSettings:levelSettings];
        assert(composite);
        [compositesMap setObject:composite forKey:composite.assetId];
     }
    return  compositesMap;
}

- (void)generateComposites:(NSDictionary*)composites
{
    for (NSString* compositeId in composites) {
        SLTCompositeInfo* compositeInfo = [composites objectForKey:compositeId];
        assert(nil != compositeInfo);
        [compositeInfo generate];
    }
}

- (void)parseAndGenerateComposites:(NSDictionary*)boardNode withLevelSettings:(SLTLevelSettings *)levelSettings forCells:(SLTCellMatrix*)cells
{
    assert(levelSettings);
    assert(boardNode);
    assert(cells);
    NSArray* compositeNodes = [boardNode objectForKey:@"composites"];
    assert(nil != compositeNodes);
    NSDictionary* composites = [self parseComposites:compositeNodes withLevelSettings:levelSettings forCells:cells];
    [self generateComposites:composites];
}

- (NSMutableArray*)chunkAssetInfoList:(NSArray*)chunkAssetsNode
{
    assert(chunkAssetsNode);
    assert([chunkAssetsNode isKindOfClass:[NSArray class]]);
    NSMutableArray* chunkAssetInfoList = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [chunkAssetsNode count]; ++i) {
        assert([[chunkAssetsNode objectAtIndex:i] isKindOfClass:[NSDictionary class]]);
        NSDictionary* assetData = [chunkAssetsNode objectAtIndex:i];
        assert(assetData);
        id stateId = [assetData objectForKey:@"stateId"];
        if (nil != stateId) {
            assert([stateId isKindOfClass:[NSNumber class]]);
            stateId = [[assetData objectForKey:@"stateId"] stringValue];
        }
        assert([[assetData objectForKey:@"assetId"] isKindOfClass:[NSString class]]);
        SLTChunkAssetInfo* chunkAsset = [[SLTChunkAssetInfo alloc] initWithAssetId:[assetData objectForKey:@"assetId"]  count:[[assetData objectForKey:@"count"] integerValue] andStateId:stateId];
        assert(chunkAsset);
        [chunkAssetInfoList insertObject:chunkAsset atIndex:i];
    }
    return chunkAssetInfoList;
}

- (NSMutableArray*) retrieveCellNodes:(NSDictionary*)chunkNode fromCellMatrix:(SLTCellMatrix*)cells
{
    NSArray* chunkCellNodes = [chunkNode objectForKey:@"cells"];
    assert(chunkCellNodes);
    NSMutableArray* chunkCells = [[NSMutableArray alloc] init];
    assert(chunkCells);
    for (NSUInteger i = 0; i < chunkCellNodes.count; ++i) {
        assert([[chunkCellNodes objectAtIndex:i] isKindOfClass:[NSArray class]]);
        NSArray* chunkCellNode = [chunkCellNodes objectAtIndex:i];
        assert(chunkCellNode);
        NSUInteger xCoord = [[chunkCellNode objectAtIndex:0] integerValue];
        NSUInteger yCoord = [[chunkCellNode objectAtIndex:1] integerValue];
        SLTCell* cell = [cells retrieveCellAtRow:xCoord andColumn:yCoord];
        assert(cell);
        [chunkCells insertObject:cell atIndex:i];
    }
    return chunkCells;
}

- (NSMutableArray*)parseChunks:(NSArray*)chunkNodes withLevelSettings:(SLTLevelSettings *)levelSettings forCells:(SLTCellMatrix*)cells
{
    assert(cells);
    assert(chunkNodes);
    assert(levelSettings);
    NSMutableArray* chunks = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < [chunkNodes count]; ++i) {
        NSDictionary* chunkNode = [chunkNodes objectAtIndex:i];
        assert(nil != chunkNode);
        NSMutableArray* chunkCells = [self retrieveCellNodes:chunkNode fromCellMatrix:cells];
        NSMutableArray* chunkAssetInfoList = [self chunkAssetInfoList:[chunkNode objectForKey:@"assets"]];
        assert(chunkAssetInfoList);
        SLTChunk* chunk = [[SLTChunk alloc] initWithChunkCells:chunkCells andChunkAssetInfos:chunkAssetInfoList andLevelSettings:levelSettings];
        assert(chunk);
        [chunks addObject:chunk];
    }
    return chunks;
}

- (void)generateChunks:(NSArray*)chunks
{
    
    for (NSUInteger i = 0; i < chunks.count; ++i) {
        SLTChunk* chunk = [chunks objectAtIndex:i];
        assert(nil != chunk);
        [chunk generate];
    }
}

- (void)parseAndGenerateChunks:(NSDictionary*)boardNode withLevelSettings:(SLTLevelSettings *)levelSettings forCells:(SLTCellMatrix*)cells
{
    assert(levelSettings);
    assert(cells);
    assert(boardNode);
    NSArray* chunkNodes = [boardNode objectForKey:@"chunks"];
    assert(chunkNodes);
    NSArray* chunks = [self parseChunks:chunkNodes withLevelSettings:levelSettings forCells:cells];
    [self generateChunks:chunks];
}

- (void)fillProperties:(NSArray*)cellProperties ofCell:(SLTCell*)cell
{
    for (NSUInteger i = 0; i < cellProperties.count; ++i) {
        NSDictionary* property = [cellProperties objectAtIndex:i];
        assert(property);
        NSArray* coords = [property objectForKey:@"coords"];
        assert([coords isKindOfClass:[NSArray class]]);
        if (([[coords objectAtIndex:0] integerValue] == cell.x) && ([[coords objectAtIndex:1] integerValue] == cell.y)) {
            cell.properties = [property objectForKey:@"value"];
        }
    }
}

- (void)markCell:(SLTCell*)cell fromBlockedCells:(NSArray*)blockedCells
{
    for (NSUInteger i = 0; i < blockedCells.count; ++i) {
        NSArray* blockedCell = [blockedCells objectAtIndex:i];
        assert(blockedCell);
        assert([blockedCell isKindOfClass:[NSArray class]]);
        if (([[blockedCell objectAtIndex:0] integerValue] == cell.x) && ([[blockedCell objectAtIndex:1] integerValue] == cell.y)) {
            cell.isBlocked = true;
        }
    }
}

- (void)createEmptyCellsForCellMatrix:(SLTCellMatrix*)boardVector withBoardNode:(NSDictionary*)rawBoard
{
    assert(nil != boardVector);
    NSArray* blockedCells = [rawBoard objectForKey:@"blockedCells"];
    NSDictionary* properties = [rawBoard objectForKey:@"properties"];
    NSArray* cellProperties = nil;
    if (properties && [properties objectForKey:@"cell"]) {
        cellProperties = [properties objectForKey:@"cell"];
    }
    for (NSUInteger i = 0; i < boardVector.height; ++i) {
        for (NSUInteger j = 0 ; j < boardVector.width; ++j) {
            SLTCell* cell = [[SLTCell alloc] initWithX:j andY:i];
            assert(cell);
            [boardVector insertCell:cell atRow:j andColumn:i];
            if (cellProperties && cellProperties.count) {
                [self fillProperties:cellProperties  ofCell:cell];
            }
            if (blockedCells && blockedCells.count) {
                [self markCell:cell fromBlockedCells:blockedCells];
            }
        }
    }
}

- (SLTCellMatrix*)parseBoardCells:(NSDictionary*)boardNode withLevelSettings:(SLTLevelSettings *)levelSettings
{
    assert(boardNode);
    SLTCellMatrix* cells = [[SLTCellMatrix alloc] initWithWidth:[[boardNode objectForKey:@"cols"] integerValue] andHeight:[[boardNode objectForKey:@"rows"] integerValue]];
    assert(cells);
    [self createEmptyCellsForCellMatrix:cells withBoardNode:boardNode];
    [self parseAndGenerateComposites:boardNode withLevelSettings:levelSettings forCells:cells];
    [self parseAndGenerateChunks:boardNode withLevelSettings:levelSettings forCells:cells];
    return cells;
}

- (NSDictionary*)boardNodeProperties:(NSDictionary*)boardNode
{
    assert(boardNode);
    NSDictionary* properties = [boardNode objectForKey:@"properties"];
    NSDictionary* boardProperties = nil;
    if (properties) {
        boardProperties = [properties objectForKey:@"board"];
    }
    return boardProperties;
}

- (SLTLevelBoard*)parseLevelBoard:(NSDictionary *)boardNode withLevelSettings:(SLTLevelSettings *)levelSettings
{
    SLTCellMatrix* cells = [self parseBoardCells:boardNode withLevelSettings:levelSettings];
    SLTLevelBoard* levelBoard = [[SLTLevelBoard alloc] initWithCellMatrix:cells andProperties:[self boardNodeProperties:boardNode]];
    return levelBoard;
}

- (NSMutableDictionary*)parseLevelBoards:(NSDictionary*)boardNodes withLevelSettings:(SLTLevelSettings *)levelSettings
{
    assert(nil != boardNodes);
    NSMutableDictionary* boards = [[NSMutableDictionary alloc] init];
    for (NSString* key in boardNodes) {
        assert(key);
        NSDictionary* boardNode = [boardNodes objectForKey:key];
        assert(nil != boardNode);
        SLTLevelBoard* levelBoard = [self parseLevelBoard:boardNode withLevelSettings:levelSettings];
        assert(nil != levelBoard);
        [boards setObject:levelBoard forKey:key];
    }
    return boards;
}

@end
