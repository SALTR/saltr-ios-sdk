/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTAssetInstance.h"

@implementation SLTAssetInstance

@synthesize token = _token;
@synthesize states = _states;
@synthesize properties = _properties;

- (id)initWithToken:(NSString *)theToken states:(NSMutableArray *)theStates andProperties:(NSDictionary *)theProperties
{
    self = [super init];
    if (self) {
        _token = theToken;
        _states = theStates;
        _properties = theProperties;
    }
    return self;
}

//- (NSString *)description
//{
//    NSString* superDescription = [super description];
//    return [NSString stringWithFormat: @"AssetInstance : [state : %@], %@", self.state, superDescription];
//}

//- (BOOL)isEqual:(SLTAssetInstance*)object
//{
//    if (object == self) {
//        return YES;
//    }
//    return [super isEqual:object] && [self.state isEqualToString:object.state];
//}

@end
