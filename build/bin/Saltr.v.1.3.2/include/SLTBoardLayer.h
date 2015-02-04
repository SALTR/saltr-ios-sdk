/*
 * @file SLTBoardLayer.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/// <summary>
/// The SLTBoardLayer class represents the game board's layer.
/// </summary>
@interface SLTBoardLayer : NSObject

/// The unique identifier of the layer.
@property (nonatomic, strong, readonly) NSString* token;

/// The layer's ordering index.
@property (nonatomic, assign, readonly) NSInteger index;

/**
 * Inits an instance of @b SLTBoardLayer class with the given token and layer index.
 * @param theToken The unique identifier of the layer.
 * @param theLayerIndex The layer's ordering index.
 * @return The instance of @b SLTBoardLayer class.
 */
-(id) initWithToken:(NSString*)theToken andLayerIndex:(NSInteger)theLayerIndex;

@end
