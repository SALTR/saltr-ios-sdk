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
#import "SLTLevelBoardParser.h"
#import "SLTLevelSettings.h"

@interface SLTLevel() {
    NSMutableDictionary* _boards;
    NSDictionary* _rootNode;
    NSDictionary* _boardsNode;
}
@end

@implementation SLTLevel

@synthesize levelId = _levelId;
@synthesize contentDataUrl = _contentDataUrl;
@synthesize index = _index;
@synthesize properties = _properties;
@synthesize version = _version;
@synthesize levelSettings = _levelSettings;
@synthesize contentReady = _contentReady;

//TODO It should be nice to have validation for the values of parameters.

- (id)initWithLevelId:(NSString*)theId index:(NSString*)theIndex contentDataUrl:(NSString*)theContentDataUrl properties:(id)theProperties andVersion:(NSString*)theVersion
{
    self = [super init];
    if (self) {
        _levelId = theId;
        _index = theIndex;
        _contentDataUrl = theContentDataUrl;
        _properties = theProperties;
        _version = theVersion;
        _rootNode = nil;
        _boardsNode = nil;
        _levelSettings = nil;
        _contentReady = false;
    }
    return self;
}

- (NSDictionary*)keyset
{
    return _levelSettings.keySetMap;
}

- (SLTLevelBoard*)boardWithId:(NSString*)boardId
{
    if (nil != boardId) {
        return [_boards objectForKey:boardId];
    }
    return nil;
}

- (void)updateContent:(NSDictionary*)theRootNode
{
    if (!theRootNode) {
        return;
    }
    _rootNode = theRootNode;
    _boardsNode = [_rootNode objectForKey:@"boards"];
    assert(_boardsNode);
    _properties = [_rootNode objectForKey:@"properties"];
    _levelSettings = [[SLTLevelBoardParser sharedInstance] parseLevelSettings:_rootNode];
    [self generateAllBoards];
    _contentReady = true;
}

- (void)generateAllBoards
{
    if (_boardsNode) {
        _boards = [[SLTLevelBoardParser sharedInstance] parseLevelBoards:_boardsNode withLevelSettings:_levelSettings];
    }
}

- (void)generateBoardWithId:(NSString*)boardId
{
    if (_boardsNode && boardId) {
        NSMutableDictionary* boardNode = [_boardsNode objectForKey:boardId];
        SLTLevelBoard* board = [[SLTLevelBoardParser sharedInstance] parseLevelBoard:boardNode withLevelSettings:_levelSettings];
        assert(board);
        [_boards setObject:board forKey:boardId];
    }
}

@end
