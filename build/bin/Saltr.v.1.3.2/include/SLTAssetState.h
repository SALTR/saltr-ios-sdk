/*
 * @file SLTAssetState.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/// <summary>
/// The SLTAssetState class represents the asset state and provides the state related properties.
/// </summary>
@interface SLTAssetState : NSObject

/**
 * The unique identifier of the state.
 */
@property (nonatomic, strong, readonly) NSString* token;

/**
 * The properties of the state.
 */
@property (nonatomic, strong, readonly) NSDictionary* properties;

/**
 * @brief Inits an instance of @b SLTAssetState class with the given token and properties.
 *
 * @param theToken The unique identifier of the state.
 * @param theProperties The current state related properties.
 */
- (id)initWithToken:(NSString*)theToken andProperties:(NSDictionary*)theProperties;

@end