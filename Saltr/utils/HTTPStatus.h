/*
 * @file HTTPStatus.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface HTTPStatus : NSObject

//Bad Request
+ (NSInteger)HTTP_STATUS_400;

//Forbidden
+ (NSInteger)HTTP_STATUS_403;

//Page Not Found
+ (NSInteger)HTTP_STATUS_404;

//Internal Server Error
+ (NSInteger)HTTP_STATUS_500;

//Internal Server Error
+ (NSInteger)HTTP_STATUS_502;

//Bad gateway
+ (NSInteger)HTTP_STATUS_503;

+ (NSInteger)HTTP_STATUS_OK;

+ (NSInteger)HTTP_STATUS_NOT_MODIFIED;

+ (NSArray*)HTTP_SUCCESS_CODES;

+ (BOOL)isInSuccessCodes:(NSInteger)theStatusCode;

@end
