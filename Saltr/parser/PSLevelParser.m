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
#import "PSBoardData.h"
#import "PSLevelStructure_Private.h"
#import "PSLevelBoard_Private.h"

@implementation PSLevelParser
{
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

- (void)fillBoards:(NSDictionary*)theBoards ofLevelStructure:(PSLevelStructure*)levelStructure
{
    assert(nil != theBoards);
    for (NSString* key in theBoards) {
        NSDictionary* rawBoard = [theBoards objectForKey:key];
        assert(nil != rawBoard);
        PSLevelBoard* levelBoard = [[PSLevelBoard alloc] initWithRawBoard:rawBoard andLevelStructure:levelStructure];
        assert(nil != levelBoard);
//        levelBoard.boardVector = [self parseBoard:<#(PSVector2D *)#> withBoard:<#(id)#> andBoardData:<#(PSBoardData *)#>];
        [levelStructure.boards setObject:levelBoard forKey:key];
    }
}

- (void)parseData:(id)data andFillLevelStructure:(PSLevelStructure*)levelStructure
{
    assert (nil != data);
    levelStructure.innerProperties = [data objectForKey:@"properties"];
    levelStructure.boardData = [self parseBoardData:data];
    levelStructure.boards = [[NSMutableDictionary alloc] init];
    NSDictionary* boards = [data objectForKey:@"boards"];
    [self fillBoards:boards ofLevelStructure:levelStructure];
    _dataFetched = true;
}

- (void)parseBoard:(PSVector2D*)outputBoard withBoard:(id)board andBoardData:(PSBoardData*)boardData
{
}

- (void)regenerateChunks:(PSVector2D*)outputBoard withBoard:(id)board andBoardData:(PSBoardData*)boardData
{
}

- (PSBoardData*)parseBoardData:(id)data
{
    return [[PSBoardData alloc] init];
}

@end
