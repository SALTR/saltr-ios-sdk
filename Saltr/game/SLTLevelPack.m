/*
 * @file
 * SLTLevelPack.m
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevelPack.h"

@implementation SLTLevelPack

@synthesize token = _token;

@synthesize index = _index;

@synthesize levels = _levels;

-(id)initWithToken:(NSString*)theToken index:(NSInteger)theIndex andLevels:(NSMutableArray*)theLevels
{
    self = [super init];
    if(self) {
        _token = theToken;
        _index = theIndex;
        _levels = theLevels;
    }
    return self;
}

- (NSString *)description
{
    return _token;
}

@end
