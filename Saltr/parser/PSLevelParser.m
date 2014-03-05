/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSLevelParser.h"
#import "PSVector2D.h"
#import "PSBoardData_Private.h"
#import "PSLevelStructure_Private.h"
#import "PSLevelBoard_Private.h"
#import "PSCompositeAssetTemplate.h"
#import "PSComposite.h"
#import "PSCell.h"
#import "PSChunk.h"
#import "PSAssetInChunk.h"

@implementation PSLevelParser {
}

@synthesize dataFetched = _dataFetched;

- (id)initUniqueInstance
{
    self = [super init];
    if (self) {
        _dataFetched = false;
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

- (void)parseBoards:(NSDictionary*)theBoards ofLevelStructure:(PSLevelStructure*)levelStructure
{
    assert(nil != theBoards);
    for (NSString* key in theBoards) {
        NSDictionary* rawBoard = [theBoards objectForKey:key];
        assert(nil != rawBoard);
        PSLevelBoard* levelBoard = [[PSLevelBoard alloc] initWithRawBoard:rawBoard andOwnerLevel:levelStructure];
        assert(nil != levelBoard);
        //TODO how to fill the boardVector?????
        /*levelBoard.boardVector = */[self parseBoard:rawBoard ofLevelStructure:levelStructure];
        [levelStructure.boards setObject:levelBoard forKey:key];
    }
}

- (PSSimpleAssetTemplate*)parseSingleAsset:(NSDictionary*)asset
{
    assert(nil != asset);
    NSArray* assetCells = [asset objectForKey:@"cells"];
    NSString* theType = [asset objectForKey:@"type_key"];
    NSDictionary* theKeys = [asset objectForKey:@"keys"];
    if (assetCells) {
        return [[PSCompositeAssetTemplate alloc] initWithShifts:assetCells type:theType andKeys:theKeys];
    }
    return [[PSSimpleAssetTemplate alloc] initWithType:theType andKeys:theKeys];
}

- (NSDictionary*)parseAssets:(NSDictionary*)assets
{
    assert(nil != assets);
    NSMutableDictionary* assetsMap = [[NSMutableDictionary alloc] init];
    for (NSString* key in assets) {
        NSDictionary* asset = [assets objectForKey:key];
        assert(nil != asset);
        PSSimpleAssetTemplate* assetObject = [self parseSingleAsset:asset];
        [assetsMap setObject:assetObject forKey:key];
    }
    return assetsMap;
}

- (void)parseBoardData:(NSDictionary*)data ofLevelStructure:(PSLevelStructure*)levelStructure
{
    levelStructure.boardData = [[PSBoardData alloc] init];
    levelStructure.boardData.keyset = [data objectForKey:@"keySets"];
    levelStructure.boardData.assetMap = [self parseAssets:[data objectForKey:@"assets"]];
    levelStructure.boardData.stateMap = [data objectForKey:@"assetStates"];
}

- (NSDictionary*) parseCompositesData:(NSArray*)composites ofLevelStructure:(PSLevelStructure*)levelStructure
{
    assert(nil != levelStructure);
    NSMutableDictionary* compositesMap = [[NSMutableDictionary alloc] init];
    for (NSUInteger i = 0; i < [composites count]; ++i) {
        NSDictionary* compositePrototype = [composites objectAtIndex:i];
        assert([[compositePrototype objectForKey:@"assetId"] isKindOfClass:[NSNumber class]]);
        NSString* assetId = [[compositePrototype objectForKey:@"assetId"] stringValue];
        NSArray* compositePosition = [compositePrototype objectForKey:@"position"];
        PSCell* position = [[PSCell alloc] initWithX:[[compositePosition objectAtIndex:0] integerValue] andY:[[compositePosition objectAtIndex:1] integerValue]];
        PSComposite* composite = [[PSComposite alloc] initWithId:assetId position:position andOwnerLevel:levelStructure];
        assert(nil != composite);
        [compositesMap setObject:composite forKey:composite.compositeId];
     }
    return  compositesMap;
}

- (void)generateCompositeAssets:(NSDictionary*)composites
{
    for (NSString* compositeId in composites) {
        PSComposite* composite = [composites objectForKey:compositeId];
        assert(nil != composite);
        PSCompositeAsset* compositeAsset = [composite generateAsset];
        //TODO fill the data into Vector2d board or asset basis
        //[outputBoard insertAssert:generateAsset withPosition:composite.position];
    }
}

- (void)parseAndGenerateCompositesOfBoard:(NSDictionary*)board andLevelStructure:(PSLevelStructure*)levelStructure
{
    assert(nil != levelStructure);
    NSArray* compositesData = [board objectForKey:@"composites"];
    assert(nil != compositesData);
    NSDictionary* composites = [self parseCompositesData:compositesData ofLevelStructure:levelStructure];
    [self generateCompositeAssets:composites];
}

- (void)fillAssetsOfChunk:(PSChunk*)chunk withAssetData:(NSArray*)assetsData
{
    assert(chunk);
    assert(assetsData);
    assert([assetsData isKindOfClass:[NSArray class]]);
    for (NSUInteger i = 0; i < [assetsData count]; ++i) {
        assert([[assetsData objectAtIndex:i] isKindOfClass:[NSDictionary class]]);
        NSDictionary* assetData = [assetsData objectAtIndex:i];
        assert(assetData);
        PSAssetInChunk* chunkAsset = [[PSAssetInChunk alloc] initWithAssetId:[[assetData objectForKey:@"assetId"] stringValue]  count:[[assetData objectForKey:@"count"] integerValue] andStateId:[[assetData objectForKey:@"stateId"] stringValue]];
        assert(chunkAsset);
        [chunk addChunkAsset:chunkAsset];
    }
}

- (void)fillCellsOfChunk:(PSChunk*)chunk withCellsData:(NSArray*)cellsData
{
    assert(chunk);
    assert(cellsData);
    assert([cellsData isKindOfClass:[NSArray class]]);
    for (NSUInteger i = 0; i < [cellsData count]; ++i) {
        assert([[cellsData objectAtIndex:i] isKindOfClass:[NSArray class]]);
        NSArray* cellData = [cellsData objectAtIndex:i];
        assert(cellsData);
        PSCell* cell = [[PSCell alloc] initWithX:[[cellData objectAtIndex:0] integerValue] andY:[[cellData objectAtIndex:1] integerValue]];
        assert(cell);
        [chunk addCell:cell];
    }
}

- (NSDictionary*) parseChunksData:(NSArray*)chunks ofLevelStructure:(PSLevelStructure*)levelStructure
{
    NSMutableDictionary* chunksMap = [[NSMutableDictionary alloc] init];
    for (NSUInteger i = 0; i < [chunks count]; ++i) {
        NSDictionary* chunkData = [chunks objectAtIndex:i];
        assert(nil != chunkData);
        assert(nil != [chunkData objectForKey:@"chunkId"]);
        assert([[chunkData objectForKey:@"chunkId"] isKindOfClass:[NSNumber class]]);
        NSString* chunkId = [[chunkData objectForKey:@"chunkId"] stringValue];
        assert(nil != chunkId);
        PSChunk* chunk = [[PSChunk alloc] initWithChunkId:chunkId andOwnerLevel:levelStructure];
        assert(nil != chunk);
        [self fillAssetsOfChunk:chunk withAssetData:[chunkData objectForKey:@"assets"]];
        [self fillCellsOfChunk:chunk withCellsData:[chunkData objectForKey:@"cells"]];
        [chunksMap setObject:chunk forKey:chunk.chunkId];
    }
    return chunksMap;
}

- (void)parseAndGenerateChunksOfBoard:(NSDictionary*)board andLevelStructure:(PSLevelStructure*)levelStructure
{
    assert(nil != levelStructure);
    NSArray* chunksData = [board objectForKey:@"chunks"];
    assert(nil != chunksData);
    NSDictionary* chunks = [self parseChunksData:chunksData ofLevelStructure:levelStructure];
//    [self generateCompositeAssets:chunks];
}

- (void)parseBoard:(NSDictionary*)board ofLevelStructure:(PSLevelStructure*)levelStructure
{
    assert(nil != levelStructure);
    [self parseAndGenerateCompositesOfBoard:board andLevelStructure:levelStructure];
    [self parseAndGenerateChunksOfBoard:board andLevelStructure:levelStructure];
}

- (void)parseData:(id)data andFillLevelStructure:(PSLevelStructure*)levelStructure
{
    assert (nil != data);
    levelStructure.innerProperties = [data objectForKey:@"properties"];
    [self parseBoardData:data ofLevelStructure:levelStructure];
    levelStructure.boards = [[NSMutableDictionary alloc] init];
    NSDictionary* boards = [data objectForKey:@"boards"];
    [self parseBoards:boards ofLevelStructure:levelStructure];
    _dataFetched = true;
}

- (void)regenerateChunks:(PSVector2D*)outputBoard withBoard:(id)board andBoardData:(PSBoardData*)boardData
{
}

@end
