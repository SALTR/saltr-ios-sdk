/*
 * @file
 * SLTFeature.h
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/**
 * The public interface of game @b SLTFeature class.
 */
@interface SLTFeature : NSObject

/// The token of current @b SLTFeature
@property (nonatomic, strong, readonly) NSString* token;

/// The properties of current @b SLTFeature
@property (nonatomic, strong, readonly) NSDictionary* properties;

/// The default properties of current @b SLTFeature
@property (nonatomic, assign, readonly) BOOL required;

/**
 * @brief Inits instance of SLTFeature class with given token, properties and default properties
 *
 * @param theToken - feature token
 * @param theProperties - feature properties
  * @param theRequiredFlag - feature required flag
 * @return - The instance of SLTFeature class
 */
- (id) initWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties andRequired:(BOOL)theRequiredFlag;


@end
