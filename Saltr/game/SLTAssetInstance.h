/*
 * @file
 * SLTAssetInstance.h
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

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
 *                       534,
 *                       535
 *
 *                     ],
 *          "type_key": "normal"
 *
 *       },
 *  }
 * }
 */

@interface SLTAssetInstance : NSObject

/// the token
@property (nonatomic, strong, readonly) NSString* token;

/// the states
@property (nonatomic, strong, readonly) NSMutableArray* states;

/// the properties
@property (nonatomic, strong, readonly) NSDictionary* properties;

/**
 * @brief Inits an instance of @b SLTAssetInstance class with the given token, states and properties
 *
 * @param theToken - the token
 * @param theStates - the states
 * @param theProperties - the properties
 * @return - The instance of @b SLTAssetInstance class
 */
- (id)initWithToken:(NSString *)theToken states:(NSMutableArray *)theStates andProperties:(NSDictionary *)theProperties;

@end
