/*
 * @file SLTAssetInstance.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/// <summary>
/// The SLTAssetInstance class represents the game asset instance placed on board.
/// It holds the unique identifier of the asset and current instance related states and properties.
/// </summary>
@interface SLTAssetInstance : NSObject

/// The unique identifier of the asset.
@property (nonatomic, strong, readonly) NSString* token;

/// The current instance states.
@property (nonatomic, strong, readonly) NSMutableArray* states;

/// The current instance properties.
@property (nonatomic, strong, readonly) NSDictionary* properties;

/**
 * @brief Inits an instance of @b SLTAssetInstance class with the given token, states and properties.
 *
 * @param theToken The unique identifier of the asset.
 * @param theStates The current instance states.
 * @param theProperties The current instance properties.
 * @return The instance of @b SLTAssetInstance class.
 */
- (id)initWithToken:(NSString *)theToken states:(NSMutableArray *)theStates andProperties:(NSDictionary *)theProperties;

@end
