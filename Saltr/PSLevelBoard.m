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
#import "PSLevelParser.h"

@implementation PSLevelBoard

@synthesize ownerLevel = _ownerLevel;
@synthesize rows = _rows;
@synthesize cols = _cols;
@synthesize position = _position;
@synthesize boardVector = _boardVector;
@synthesize rawBoard = _rawBoard;
@synthesize boardData = _boardData;

- (id)initWithRawBoard:(NSDictionary*)theRawBoard andOwnerLevel:(PSLevelStructure*)theLevelStructure
{
    self = [super init];
    if (self) {
        _ownerLevel = theLevelStructure;
        _rawBoard = theRawBoard;
        _cols = [[_rawBoard objectForKey:@"cols"] integerValue];
        assert(0 <= _cols);
        _rows = [[_rawBoard objectForKey:@"rows"] integerValue];
        assert(0 <= _rows);
        _boardData = _ownerLevel.boardData;
        _position = [_rawBoard objectForKey:@"position"];
        _boardVector = [[PSVector2D alloc] initWithWidth:_cols andHeight:_rows];
    }
    return self;
}

- (void)regenerateChunks
{
    [[PSLevelParser sharedInstance] regenerateChunksWithRawBoard:_rawBoard forLevelBoard:self];
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
    NSDictionary* boardProperties = nil;
    NSDictionary* properties = [_rawBoard objectForKey:@"properties"];
    if (properties && [properties objectForKey:@"board"]) {
        boardProperties = [properties objectForKey:@"board"];
    }
    return boardProperties;
}

@end
