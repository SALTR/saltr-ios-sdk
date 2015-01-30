/*
 * @file SLT2DAssetState.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTAssetState.h"

/// <summary>
/// The SLT2DAssetState class represents the 2D asset state and provides the state related properties.
/// </summary>
@interface SLT2DAssetState : SLTAssetState

/// The X coordinate of the pivot relative to the top left corner, in pixels.
@property (nonatomic, strong, readonly) NSNumber* pivotX;

/// The Y coordinate of the pivot relative to the top left corner, in pixels.
@property (nonatomic, strong, readonly) NSNumber* pivotY;

/**
 * @brief Inits an instance of @b SLT2DAssetState class with the given token, properties, pivotX and pivotY
 *
 * @param theToken - the token
 * @param theProperties - the properties
 * @param thePivotX - the pivotX
 * @param thePivotY - the pivotY
 * @return - The instance of @b SLT2DAssetState class
 */

/**
 * @brief Inits an instance of @b SLT2DAssetState class with the given token, properties, pivotX and pivotY
 *
 * @param theToken The unique identifier of the state.
 * @param theProperties The current state related properties.
 * @param thePivotX The X coordinate of the pivot relative to the top left corner, in pixels.
 * @param thePivotY The Y coordinate of the pivot relative to the top left corner, in pixels.
 */
- (id)initWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties pivotX:(NSNumber *)thePivotX andPivotY:(NSNumber *)thePivotY;

@end
