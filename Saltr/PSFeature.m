//
//  PSFeature.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSFeature.h"

@implementation PSFeature

@synthesize token = _token;
@synthesize properties = _properties;
@synthesize defaultProperties;

-(id) initWithToken:(NSString*)theToken
  defaultProperties:(NSArray*)theDefaultProperties
      andProperties:(NSArray*)theProperties
{
    self = [super init];
    if (self) {
        _token = theToken;
        self.defaultProperties = theDefaultProperties;
        _properties = theProperties;
    }
    return self;
}

- (NSArray*)properties
{
    return (_properties == NULL) ? self.defaultProperties : _properties;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Feature { token : %@ , value : %@}", self.token, self.properties];
}

@end
