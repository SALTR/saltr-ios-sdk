/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevel.h"
#import "SLTLevelParser.h"

@interface SLTLevel() {
    NSString* _id;
    NSMutableDictionary* _boards;
    NSDictionary* _assetMap;
}
@end

@implementation SLTLevel

@synthesize index = _index;
@synthesize properties = _properties;
@synthesize contentUrl = _contentUrl;
@synthesize contentReady = _contentReady;
@synthesize version = _version;
@synthesize localIndex = _localIndex;
@synthesize packIndex = _packIndex;

///@todo It should be nice to have validation for the values of parameters.
-(id) initWithLevelId:(NSString*)theId index:(int)theIndex localIndex:(int)theLocalIndex packIndex:(int)thePackIndex contentUrl:(NSString*)theContentUrl properties:(id)theProperties andVersion:(NSString*)theVersion
{
    self = [super init];
    if (self) {
        _id = theId;
        _index = theIndex;
        _localIndex = theLocalIndex;
        _packIndex = thePackIndex;
        _contentUrl = theContentUrl;
        _properties = theProperties;
        _version = theVersion;
        _contentReady = false;
    }
    return self;
}

-(SLTLevelParser*) getParser
{
    NSException* exception = [NSException
                                exceptionWithName:@"VirtualMethodException"
                                reason:@"Virtual Method not implemented"
                                userInfo:nil];
    @throw exception;
}

//- (SLTLevelBoard*)boardWithId:(NSString*)boardId
//{
//    if (nil != boardId) {
//        return [_boards objectForKey:boardId];
//    }
//    return nil;
//}

- (void)updateContent:(NSDictionary*)theRootNode
{
    NSDictionary* boardsNode = [theRootNode objectForKey:@"boards"];
    assert(boardsNode);
    
    SLTLevelParser* parser = [self getParser];
    
    _properties = [theRootNode objectForKey:@"properties"];
    
    @try {
        _assetMap = [parser parseLevelAssets:theRootNode];
    }
    @catch (NSException *exception) {
        NSLog(@"[SALTR: ERROR] Level content asset parsing failed.");
    }
    
    @try {
        _boards = [parser parseLevelContentFromBoardNodes:boardsNode andAssetMap:_assetMap];
    }
    @catch (NSException *exception) {
        NSLog(@"SALTR: ERROR] Level content boards parsing failed.");
    }
    
    [self regenerateAllBoards];
    _contentReady = true;
}

/*
public function regenerateAllBoards():void {
    for each (var board:SLTBoard in _boards) {
        board.regenerate();
    }
}
*/
- (void)regenerateAllBoards
{
    //anakonda
}

/*
public function regenerateBoard(boardId:String):void {
    if (_boards != null && _boards[boardId] != null) {
        var board:SLTBoard = _boards[boardId];
        board.regenerate();
    }
}
*/

- (void)regenerateBoardWithId:(NSString*)boardId
{
    //anakonda
}

@end
