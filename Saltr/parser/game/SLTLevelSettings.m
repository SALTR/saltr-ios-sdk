/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevelSettings.h"

@implementation SLTLevelSettings

@synthesize assetMap = _assetMap;
@synthesize keySetMap = _keySetMap;
@synthesize stateMap = _stateMap;

- (id)initWithAssetMap:(NSDictionary*)theAssetMap keySetMap:(NSDictionary*)theKeySetMap andStateMap:(NSDictionary*)theStateMap
{
    self = [super init];
    if (self) {
        _assetMap = theAssetMap;
        _keySetMap = theKeySetMap;
        _stateMap = theStateMap;
    }
    return self;
}

@end
