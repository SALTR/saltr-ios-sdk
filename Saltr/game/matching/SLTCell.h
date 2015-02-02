/*
 * @file SLTCell.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class SLTAssetInstance;

/// <summary>
/// The SLTCell class represents the matching board cell.
/// </summary>
@interface SLTCell : NSObject

/// The column of the cell.
@property (nonatomic, assign, readwrite) NSUInteger col;

/// The row of the cell.
@property (nonatomic, assign, readwrite) NSUInteger row;

/// The blocked state of the cell.
@property (nonatomic, assign, readwrite) BOOL isBlocked;

/// The properties of the cell.
@property (nonatomic, strong, readwrite) NSDictionary* properties;

/**
 * @brief Inits an instance of @b SLTCell class with the given column and row.
 *
 * @param col The column of the cell.
 * @param row The row of the cell.
 * @return The instance of @b SLTCell class.
 */
-(id) initWithCol:(NSInteger)col andRow:(NSInteger)row;

/**
 * Returns the asset instance by layer identifier.
 * @param layerId The layer identifier.
 * @return SLTAssetInstance The asset instance that is positioned in the cell in the layer specified by layerId.
 */
-(SLTAssetInstance*) getAssetInstanceByLayerId:(NSString*)layerId;

/**
 * Returns the asset instance by layer index.
 * @param layerIndex The layer index.
 * @return SLTAssetInstance The asset instance that is positioned in the cell in the layer specified by layerIndex.
 */
-(SLTAssetInstance*) getAssetInstanceByLayerIndex:(NSInteger)layerIndex;

@end