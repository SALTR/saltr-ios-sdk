/*
 * @file SLTLevel.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevel.h"
#import "SLTLevelParser.h"
#import "SLTBoard.h"
#import "SLTMatchingLevelParser.h"
#import "SLT2DLevelParser.h"

@interface SLTLevel() {
    NSString* _id;
    NSString* _levelType;
    NSMutableDictionary* _boards;
    NSDictionary* _assetMap;
}
@end

@implementation SLTLevel

@synthesize variationId = _variationId;
@synthesize index = _index;
@synthesize properties = _properties;
@synthesize contentUrl = _contentUrl;
@synthesize contentReady = _contentReady;
@synthesize version = _version;
@synthesize localIndex = _localIndex;
@synthesize packIndex = _packIndex;

///@todo It should be nice to have validation for the values of parameters.
-(id) initWithLevelId:(NSString*)theId variationId:(NSString*)theVariationId levelType:(NSString*)theLevelType index:(NSInteger)theIndex localIndex:(NSInteger)theLocalIndex packIndex:(NSInteger)thePackIndex contentUrl:(NSString*)theContentUrl properties:(id)theProperties andVersion:(NSString*)theVersion
{
    self = [super init];
    if (self) {
        _id = theId;
        _variationId = theVariationId;
        _levelType = theLevelType;
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

-(SLTLevelParser*) getParser:(NSString*)levelType
{
    if ([levelType isEqualToString:LEVEL_TYPE_MATCHING]) {
        return [SLTMatchingLevelParser sharedInstance];
    } else if([levelType isEqualToString:LEVEL_TYPE_2DCANVAS]) {
        return [SLT2DLevelParser sharedInstance];
    }
    return nil;
}

- (SLTBoard*)boardWithId:(NSString*)boardId
{
    if (nil != boardId) {
        return [_boards objectForKey:boardId];
    }
    return nil;
}

- (void)updateContent:(NSDictionary*)theRootNode
{
    NSDictionary* boardsNode = [theRootNode objectForKey:@"boards"];
    assert(boardsNode);
    
    SLTLevelParser* parser = [self getParser:_levelType];
    
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

- (void)regenerateAllBoards
{
    for (NSString* key in _boards) {
        SLTBoard* board = [_boards objectForKey:key];
        assert(nil != board);
        [board regenerate];
    }
}

- (void)regenerateBoardWithId:(NSString*)boardId
{
    if (nil != _boards) {
        SLTBoard* board = [_boards objectForKey:boardId];
        if (nil != board) {
            [board regenerate];
        }
    }
}

@end
