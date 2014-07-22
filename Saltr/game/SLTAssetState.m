/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTAssetState.h"

@implementation SLTAssetState

@synthesize token = _token;
@synthesize properties = _properties;

- (id)initWithToken:(NSString*)theToken andProperties:(NSDictionary*)theProperties
{
    self = [super init];
    if (self) {
        _token = theToken;
        _properties = theProperties;
    }
    return self;
}

@end