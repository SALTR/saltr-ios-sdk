/*
 * @file HTTPStatus.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "HTTPStatus.h"

static NSArray* httpSuccessCodes;

@implementation HTTPStatus

+ (NSInteger)HTTP_STATUS_400;
{
    return 400;
}

+ (NSInteger)HTTP_STATUS_403
{
    return 403;
}

+ (NSInteger)HTTP_STATUS_404
{
    return 404;
}

+ (NSInteger)HTTP_STATUS_500
{
    return 500;
}

+ (NSInteger)HTTP_STATUS_502
{
    return 502;
}

+ (NSInteger)HTTP_STATUS_503
{
    return 503;
}

+ (NSInteger)HTTP_STATUS_OK
{
    return 200;
}

+ (NSInteger)HTTP_STATUS_NOT_MODIFIED
{
    return 304;
}

+ (NSArray*)HTTP_SUCCESS_CODES
{
    if(nil == httpSuccessCodes) {
        httpSuccessCodes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:[self HTTP_STATUS_OK]], nil];
    }
    return httpSuccessCodes;
}

+ (BOOL)isInSuccessCodes:(NSInteger)theStatusCode
{
    return [httpSuccessCodes containsObject:[NSNumber numberWithInteger:theStatusCode]];
}

@end
