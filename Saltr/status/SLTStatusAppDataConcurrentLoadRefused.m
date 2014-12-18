/*
 * @file SLTStatusAppDataConcurrentLoadRefused.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTStatusAppDataConcurrentLoadRefused.h"

@implementation SLTStatusAppDataConcurrentLoadRefused

-(id) init
{
    self = [super initWithCode:CLIENT_APP_DATA_CONCURRENT_LOAD_REFUSED andMessage:@"[SALTR] appData load refused. Previous load is not complete"];
    return self;
}

@end
