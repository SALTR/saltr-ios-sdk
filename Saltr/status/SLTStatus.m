/*
 * @file SLTStatus.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTStatus.h"

@implementation SLTStatus

@synthesize code = _code;
@synthesize message = _message;

- (id)initWithCode:(SLTStatusCode)theCode andMessage:(NSString*)theMessage
{
    self = [super init];
    if (self) {
        _code = theCode;
        _message = theMessage;
    }
    return  self;
}

@end
