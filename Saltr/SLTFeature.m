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
@synthesize defaultProperties;

-(id) initWithToken:(NSString* )theToken
  defaultProperties:(NSDictionary* )theDefaultProperties
      andProperties:(NSDictionary* )theProperties
{
    self = [super init];
    if (self) {
        _token = theToken;
        self.defaultProperties = theDefaultProperties;
        _properties = theProperties;
    }
    return self;
}

- (NSDictionary* )properties
{
    return (_properties == NULL) ? self.defaultProperties : _properties;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Feature {[token : %@], [value : %@]}", self.token, self.properties];
}

@end
