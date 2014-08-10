/*
 * @file SLT2DAssetInstance.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTAssetInstance.h"

@interface SLT2DAssetInstance : SLTAssetInstance

/// the x
@property (nonatomic, strong, readonly) NSNumber* x;

/// the y
@property (nonatomic, strong, readonly) NSNumber* y;

/// the rotation
@property (nonatomic, strong, readonly) NSNumber* rotation;

/**
 * @brief Inits an instance of @b SLT2DAssetInstance class with the given token, states,  properties and rotation
 *
 * @param theToken - the token
 * @param theStates - the states
 * @param theProperties - the properties
 * @param theX - the x
 * @param theY - the y
 * @param theRotation - the rotation
 * @return - The instance of @b SLT2DAssetInstance class
 */
- (id)initWithToken:(NSString *)theToken states:(NSMutableArray *)theStates properties:(NSDictionary *)theProperties x:(NSNumber *)theX y:(NSNumber *)theY andRotation:(NSNumber *)theRotation;

@end
