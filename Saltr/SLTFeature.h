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

@interface SLTFeature : NSObject

/// The token of current @b PSFeature
@property (nonatomic, strong, readonly) NSString* token;

/// The properties of current @b PSFeature
@property (nonatomic, strong, readonly, getter = properties) NSDictionary* properties;

/// The default properties of current @b PSFeature
@property (nonatomic, strong) NSDictionary* defaultProperties;

/**
 * @brief Inits instance of PSFeature class with given token, properties and default properties
 *
 * @param theToken - feature token
 * @param theDefaultProperties - feature default properties
 * @param theProperties - feature properties
 * @return - The instance of PSFeature class
 */
-(id) initWithToken:(NSString*)theToken defaultProperties:(NSDictionary*)theDefaultProperties andProperties:(NSDictionary*)theProperties;

@end
