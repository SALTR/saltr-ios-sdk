/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSChunk.h"
#import "PSCell.h"
#import "PSAssetInChunk.h"
#import "PSLevelStructure.h"
#import "PSBoardData.h"

@interface PSChunk() {
    NSDictionary* _boardAssetMap;
    NSDictionary* _boardStateMap;
}
@end

@implementation PSChunk

@synthesize ownerLevel = _ownerLevel;
@synthesize chunkId = _chunkId;
@synthesize cells = _cells;
@synthesize chunkAssets = _chunkAssets;

- (id)initWithChunkId:(NSString*)theChunkId andOwnerLevel:(PSLevelStructure*)theOwnerLevel
{
    self = [super init];
    if (self) {
        assert(nil != theChunkId);
        assert(nil != theOwnerLevel);
        _chunkId = theChunkId;
        _ownerLevel = theOwnerLevel;
        _cells = [[NSMutableArray alloc] init];
        _chunkAssets = [[NSMutableArray alloc] init];
        _boardAssetMap = theOwnerLevel.boardData.assetMap;
        _boardStateMap = theOwnerLevel.boardData.stateMap;
    }
    return self;
}

- (void) addCell:(PSCell*)theCell
{
    if (!theCell) {
        return;
    }
    [_cells addObject:theCell];

}

- (void) addChunkAsset:(PSAssetInChunk*)theChunkAsset
{
    if (!theChunkAsset) {
        return;
    }
    [_chunkAssets addObject:theChunkAsset];
}


- (NSString *)description
{
    return [NSString stringWithFormat: @"Chunk : [chunkId : %@], [cells : %@], [chunkAssets: %@], [ownerLevel : %@]", self.chunkId, self.cells, self.chunkAssets, self.ownerLevel];
}

@end
