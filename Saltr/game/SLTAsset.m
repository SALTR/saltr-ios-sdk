/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTAsset.h"
#import "SLTAssetInstance.h"
#import "SLTAssetState.h"

@interface SLTAsset() {
    NSDictionary* _stateMap;
}
@end

@implementation SLTAsset

@synthesize token = _token;
@synthesize properties = _properties;

- (id) initWithToken:(NSString*)theToken stateMap:(NSDictionary*)theStateMap andProperties:(NSDictionary*)theProperties
{
    self = [super init];
    if (self) {
        _token = theToken;
        _properties = theProperties;
        _stateMap = theStateMap;
    }
    return self;
}

- (NSMutableArray *) getInstanceStates:(NSArray*)stateIds
{
    NSMutableArray* states = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i<stateIds.count; ++i) {
        SLTAssetState* state = [_stateMap objectForKey:stateIds[i]];
        if(state != nil) {
            [states addObject:state];
        }
    }
    return states;
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"[Asset] token: %@, properties: %@", self.token, self.properties];
}

//- (BOOL)isEqual:(SLTAsset*)object
//{
//    if (object == self) {
//        return YES;
//    }
//    return [self.type isEqualToString:object.type] && [self.keys isEqual:object.keys];
//}

@end
