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

/// <summary>
/// The SLT2DBoardLayer class represents the game 2D board's layer.
/// </summary>
@interface SLT2DBoardLayer : SLTBoardLayer

/// The asset instances of the layer.
@property (nonatomic, strong, readonly) NSMutableArray* assetInstances;

//TODO:TIGR check theToken param (should be layerId)

/**
 * @brief Inits an instance of @b SLT2DBoardLayer class with the given layer id and layer index.
 *
 * @param theToken The token
 * @param theLayerIndex The layer's ordering index.
 * @return The instance of @b SLT2DBoardLayer class.
 */
-(id) initWithToken:(NSString*)theToken andLayerIndex:(NSInteger)theLayerIndex;

//TODO:TIGR assAssetInstance should be not visible

/**
 * @brief Add SLT2DAssetInstance class instance
 *
 * @param theAssetInstance - the SLT2DAssetInstance instance
 */
-(void) addAssetInstance:(SLT2DAssetInstance *)theAssetInstance;

@end
