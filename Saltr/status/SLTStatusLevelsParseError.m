/*
 * @file SLTStatusLevelsParseError.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTStatusLevelsParseError.h"

@implementation SLTStatusLevelsParseError

-(id) init
{
    self = [super initWithCode:CLIENT_LEVELS_PARSE_ERROR andMessage:@"[SALTR] Failed to decode Levels."];
    return self;
}

@end
