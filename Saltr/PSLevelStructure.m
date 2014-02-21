//
//  PSLevelStructure.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSLevelStructure.h"

@interface PSLevelStructure() {

    NSDictionary* _boards;
    NSObject* _data;
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

-(id) initWithLevelId:(NSString*)theId index:(NSInteger)theIndex dataUrl:(NSString*)theDataUrl properties:(NSObject*)theProperties andVersion:(NSString*)theVersion
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

- (NSObject*)innerProperties
{
    return NULL;
}

- (void)parseData:(NSObject*)data
{
}

@end
