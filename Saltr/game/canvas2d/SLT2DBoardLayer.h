/*
 * @file SLT2DBoardLayer.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoardLayer.h"

@class SLT2DAssetInstance;

@interface SLT2DBoardLayer : SLTBoardLayer

/// the asset instances
@property (nonatomic, strong, readonly) NSMutableArray* assetInstances;

/**
 * @brief Inits an instance of @b SLT2DBoardLayer class with the given layer id and layer index
 *
 * @param theLayerId - the layer id
 * @param theLayerIndex - the layer index
 * @param theProperties - the properties
 * @return - The instance of @b SLT2DBoardLayer class
 */
-(id) initWithLayerId:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex;

/**
 * @brief Add SLT2DAssetInstance class instance
 *
 * @param theAssetInstance - the SLT2DAssetInstance instance
 */
-(void) addAssetInstance:(SLT2DAssetInstance *)theAssetInstance;

@end
