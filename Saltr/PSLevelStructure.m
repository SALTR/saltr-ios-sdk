/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSLevelStructure.h"

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
@synthesize dataFetched = _dataFetched;
@synthesize keyset = _keyset;
@synthesize version = _version;

-(id) initWithLevelId:(NSString*)theId index:(NSInteger)theIndex dataUrl:(NSString*)theDataUrl properties:(id)theProperties andVersion:(NSString*)theVersion
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

- (NSString*)boardWithId:(NSString*)boardId
{
    return NULL;
}

- (id)innerProperties
{
    return NULL;
}

- (void)parseData:(id)data
{
}

@end
