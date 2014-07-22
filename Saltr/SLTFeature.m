/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTFeature.h"

@implementation SLTFeature

@synthesize token = _token;
@synthesize properties = _properties;
@synthesize required = _required;

- (id) initWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties andRequired:(BOOL)theRequiredFlag
{
    self = [super init];
    if (self) {
        _token = theToken;
        _properties = theProperties;
        _required = theRequiredFlag;
    }
    return self;
}

- (NSString *)description {    
    return [NSString stringWithFormat: @"[SALTR] Feature {[token : %@], [value : %@]}", self.token, self.properties];
}

@end
