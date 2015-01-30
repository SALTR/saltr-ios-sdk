/*
 * @file SLTMatchingBoardLayer.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoardLayer.h"

@class SLTChunk;

/// <summary>
/// The SLTMatchingBoardLayer class represents the matching board.
/// </summary>
@interface SLTMatchingBoardLayer : SLTBoardLayer

/**
 * @brief Inits an instance of @b SLTMatchingBoardLayer class with the given identifier and index.
 *
 * @param theLayerId The layer's identifier.
 * @param theLayerIndex The layer's index.
 */
-(id)initWithToken:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex;

- (void)regenerate;

- (void)addChunk:(SLTChunk*)chunk;

@end
