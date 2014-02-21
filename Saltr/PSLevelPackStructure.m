//
//  PSLevelPackStructure.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSLevelPackStructure.h"

@implementation PSLevelPackStructure

@synthesize token = _token;
@synthesize levelStructureList = _levelStructureList;
@synthesize index = _index;

-(id) initWithToken:(NSString*)theToken levelStructureList:(NSArray*)theLevelStructureList andIndex:(NSString*)theIndex
{
    self = [super init];
    if (self) {
        _token = theToken;
        _levelStructureList = theLevelStructureList;
        _index = theIndex;
    }
    return self;
}

- (NSString *)description {
    return self.token;
}

@end
