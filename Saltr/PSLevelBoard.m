/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSLevelBoard_Private.h"
#import "PSBoardData.h"
#import "PSVector2D.h"
#import "PSLevelStructure.h"

@implementation PSLevelBoard

@synthesize level = _level;
@synthesize rows = _rows;
@synthesize cols = _cols;
@synthesize blockedCells = _blockedCells;
@synthesize position = _position;
@synthesize boardVector = _boardVector;
@synthesize rawBoard = _rawBoard;
@synthesize boardData = _boardData;

- (id)initWithRawBoard:(NSDictionary*)theRawBoard andLevelStructure:(PSLevelStructure*)theLevelStructure
{
    self = [super init];
    if (self) {
        _level = theLevelStructure;
        _rawBoard = theRawBoard;
        _cols = (NSInteger)[_rawBoard objectForKey:@"cols"];
        assert(0 <= _cols);
        _rows = (NSInteger)[_rawBoard objectForKey:@"rows"];
        assert(0 <= _rows);
        _boardData = _level.boardData;
        _blockedCells = [_rawBoard objectForKey:@"blokedCells"];
        _position = [_rawBoard objectForKey:@"position"];
    }
    return self;
}

- (void)regenerateChunks
{
}

- (NSDictionary*)composites
{
    return [_rawBoard objectForKey:@"composites"];
}

- (NSDictionary*)chunks
{
    return [_rawBoard objectForKey:@"chunks"];
}

- (id)boardProperties
{
    return nil;
}

- (id)cellProperties
{
    return nil;
}

@end
