/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevelParser.h"
#import "SLTAsset.h"
#import "SLTAssetState.h"

@implementation SLTLevelParser

-(NSMutableDictionary*) parseLevelContentFromBoardNodes:(NSDictionary*)boardNodes andAssetMap:(NSDictionary*)assetMap
{
    NSException* exception = [NSException
                              exceptionWithName:@"VirtualMethodException"
                              reason:@"[SALTR: ERROR] parseLevelContentFromBoardNodes is virtual method."
                              userInfo:nil];
    @throw exception;
}

-(NSDictionary*) parseLevelAssets:(NSDictionary*)rootNode
{
    NSDictionary* assetNodes = [rootNode objectForKey:@"assets"];
    assert(nil != assetNodes);
    NSMutableDictionary* assetMap = [[NSMutableDictionary alloc] init];
    for (NSString* key in assetNodes) {
        NSDictionary* asset = [assetNodes objectForKey:key];
        assert(nil != asset);
        SLTAsset* assetObject = [self parseAsset:asset];
        assert(nil != assetObject);
        [assetMap setObject:assetObject forKey:key];
    }
    return assetMap;
}

- (SLTAsset*) parseAsset:(NSDictionary*)asset
{
    assert(nil != asset);
    NSString* token = [asset objectForKey:@"token"];
    NSDictionary* stateMap = [self parseAssetStates:[asset objectForKey:@"states"]];
    NSDictionary* properties = [asset objectForKey:@"properties"];
    return [[SLTAsset alloc] initWithToken:token stateMap:stateMap andProperties:properties];
}

- (NSDictionary*)parseAssetStates:(NSDictionary*)stateNodes
{
    NSMutableDictionary* stateMap = [[NSMutableDictionary alloc] init];
    for (NSString* key in stateNodes) {
        NSDictionary* asset = [stateNodes objectForKey:key];
        assert(nil != asset);
        SLTAssetState* assetStateObject = [self parseAssetState:asset];
        assert(nil != assetStateObject);
        [stateMap setObject:assetStateObject forKey:key];
    }
    return stateMap;
}

-(SLTAssetState*)parseAssetState:(NSDictionary*)stateNode
{
    return [[SLTAssetState alloc] initWithToken:[stateNode objectForKey:@"token"] andProperties:[stateNode objectForKey:@"properties"]];
}

@end
