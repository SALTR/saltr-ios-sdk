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
 * The type of @b SLTAsset object, which initializes with the value of "type_key" property from the JSON.
 */
@property (nonatomic, strong, readonly) NSString* type;

/**
 * The keys of @b keys object, which initializes with the value of "keys" property from the JSON.
 * The value of @b keys property is an object with a list of key-value pairs.
 */
@property (nonatomic, strong, readonly) NSDictionary* keys;

/**
 * @brief Initializes @b SLTAsset class instance with the given type and keys
 *
 * @param theType - the type of SLTAsset instance
 * @param theKeys - the list of SLTAsset keys
 * @return - The instance of @b SLTAsset
 */
- (id)initWithType:(NSString*)theType andKeys:(NSDictionary*)theKeys;

@end
