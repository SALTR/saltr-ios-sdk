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

@interface SLT2DAssetState : SLTAssetState

/// The pivot x.
@property (nonatomic, strong, readonly) NSNumber* pivotX;

/// The pivot y.
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
- (id)initWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties pivotX:(NSNumber *)thePivotX andPivotY:(NSNumber *)thePivotY;

@end
