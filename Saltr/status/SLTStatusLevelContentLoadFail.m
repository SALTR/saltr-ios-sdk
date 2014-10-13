/*
 * @file SLTStatusLevelContentLoadFail.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTStatusLevelContentLoadFail.h"

@implementation SLTStatusLevelContentLoadFail

-(id) init
{
    self = [super initWithCode:CLIENT_LEVEL_CONTENT_LOAD_FAIL andMessage:@"Level content load has failed."];
    return self;
}

@end
