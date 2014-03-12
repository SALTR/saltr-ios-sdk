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
#import "SLTAsset.h"

@class PSCell;

/**
 * @brief This is public interface of @b SLTAssetInstance class.
 * 
 * An instance of this class holds basic asset data (type, keys) and also value of state.
 *
 * As an example, asset data with state info from the JSON looks like :
 * {
 *  "assetStates": {
 *          "534": "state1",
 *          "535": "state2"
 *  },
 *  ...
 *  "boards": {
 *      "main": {
 *          ...
 *       }
 *   }
 *  "assets": {
 *      "2835": {
 *          "keys": {
 *                  "COLOR": 1,
 *                  "CARD_SUIT": 1,
 *                  "CARD_VALUE": 1
 *                  },
 *          "states": [
 *                       534
 *                     ],
 *          "type_key": "normal"
 *
 *       },
 *  }
 * }
 */

@interface SLTAssetInstance : SLTAsset

/// the state of @b SLTAssetInstance 
@property (nonatomic, strong, readonly) NSString* state;

/**
 * @brief Inits an instance of @b SLTAssetInstance class with the given state, type and keys
 *
 * @param theState - the state value, which corresponds to the given stateId of asset instance
 * @param theType - the type of asset instance
 * @param theKeys - the keys of asset instance
 * @return - The instance of @b SLTAssetInstance class
 */
- (id)initWithState:(NSString*)theState type:(NSString*)theType andKeys:(NSDictionary*)theKeys;

@end
