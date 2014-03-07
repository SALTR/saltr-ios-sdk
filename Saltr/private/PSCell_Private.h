/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSCell.h"

@interface PSCell ()

@property (nonatomic, assign, readwrite) BOOL isBlocked;
@property (nonatomic, strong, readwrite) NSDictionary* properties;
@property (nonatomic, strong, readwrite) PSAssetInstance* assetInstance;

@end
