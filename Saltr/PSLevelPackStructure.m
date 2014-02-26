/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

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
