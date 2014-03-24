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

/**
 * @brief This is the private interface for @b SLTLevelSettings class.
 *
 * The instance holds information about asset mapping, state mapping and key set mapping
 *
 * The level settings stored in JSON have the following format:
 *
 * {
 *  "assetStates": {
 *          "534": "state1",
 *          "535": "state2"
 *  },
 *  "assets": {
 *      "2835": {...
 *      },
 *      "2487": { ...
 *      },.. }
 *   "keySets": {
 *       "COLOR": {
 *           "1": "white",...
 *       }...
 *    }
 *  }
 */
@interface SLTLevelSettings : NSObject

/// Asset mapping of level, where key is the asset id and value is the data of asset
@property (nonatomic, strong, readonly) NSDictionary* assetMap;

/// Key mapping of level, where key is the user defined "key" and the value is the set of possible values of the asset key
@property (nonatomic, strong, readonly) NSDictionary* keySetMap;

/// State mapping of level, where key is the state id and value is the string info of state
@property (nonatomic, strong, readonly) NSDictionary* stateMap;

/**
 * @brief Initializes @b SLTLevelSettings class instance with the given maps of assets, keySets and states
 *
 * @param theAssetMap - the map of assets
 * @param theKeySetMap - the map of key sets
 * @param theStateMap - the map of states
 * @return - The instance of @b SLTLevelSettings
 */
- (id)initWithAssetMap:(NSDictionary*)theAssetMap keySetMap:(NSDictionary*)theKeySetMap andStateMap:(NSDictionary*)theStateMap;

@end
