/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSLevelStructure_Private.h"
#import "PSLevelParser.h"
#import "PSBoardData.h"

@interface PSLevelStructure() {
    NSDictionary* _boards;
    id _data;
}
@end

@implementation PSLevelStructure

@synthesize levelId = _levelId;
@synthesize dataUrl = _dataUrl;
@synthesize index = _index;
@synthesize properties = _properties;
@synthesize version = _version;
@synthesize boardData;
@synthesize innerProperties;
@synthesize boards;

//TODO It should be nice to have validation for the values of parameters.

- (id)initWithLevelId:(NSString*)theId index:(NSString *)theIndex dataUrl:(NSString*)theDataUrl properties:(NSDictionary *)theProperties andVersion:(NSString*)theVersion
{
    self = [super init];
    if (self) {
        _levelId = theId;
        _index = theIndex;
        _dataUrl = theDataUrl;
        _properties = theProperties;
        _version = theVersion;
    }
    return self;
}

- (NSDictionary*)keyset
{
    return boardData.keyset;
}

- (NSString*)boardWithId:(NSString*)boardId
{
    if (nil != boardId) {
        return [boards objectForKey:boardId];
    }
    return nil;
}

@end
