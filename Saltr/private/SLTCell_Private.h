/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCell.h"

/**
 * @brief The private interface for @b SLTCell class, only for internal usage.
 * 
 * This API of @b SLTCell class gives possibility to change properties values.
 */
@interface SLTCell ()

/// Writable property of @b SLTCell instance, which shows whether the cell is blocked.
@property (nonatomic, assign, readwrite) BOOL isBlocked;

/// The properties of the cell, which value is writable.
@property (nonatomic, strong, readwrite) NSDictionary* properties;

/// Points to the @b SLTAssetInstance, that corresponds to the cell. The property is writable.
@property (nonatomic, strong, readwrite) SLTAssetInstance* assetInstance;

@end
