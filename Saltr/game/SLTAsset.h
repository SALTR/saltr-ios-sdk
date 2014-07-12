/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class SLTAssetInstance;

/**
 * @brief This is interface for @b SLTAsset class, that is being used internally only by SDK.
 *
 * This is the base class to store the basic data of asset from parsed JSON.
 *
 * As an example, the asset data from the JSON looks like :
 *
 * { ...
 *          "assets": {
 *              "2835": {
 *              "keys": {
 *                  "COLOR": 1,
 *                  "CARD_SUIT": 1,
 *                  "CARD_VALUE": 1
 *                  },
 *              "states": [
 *                       534
 *                       ],
 *              "type_key": "normal"
 *
 *              },
 *          } 
 * }...
 */
@interface SLTAsset : NSObject

/**
 * The token.
 */
@property (nonatomic, strong, readonly) NSString* token;

/**
 * The properties.
 */
@property (nonatomic, strong, readonly) NSDictionary* properties;

/**
 * @brief Initializes @b SLTAsset class instance with the given type and keys
 *
 * @param theToken - the token
 * @param theStateMap - the state map
 * @param theProperties - the properties
 * @return - The instance of @b SLTAsset
 */
- (id) initWithToken:(NSString*)theToken stateMap:(NSDictionary*)theStateMap andProperties:(NSDictionary*)theProperties;

- (SLTAssetInstance *) getInstance:(NSArray *)stateIds;

- (NSMutableArray *) getInstanceStates:(NSArray*)stateIds;

@end
