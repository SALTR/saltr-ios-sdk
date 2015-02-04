/*
 * @file SLTBoard.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/// <summary>
/// The SLTBoard class represents the game board.
/// </summary>
@interface SLTBoard : NSObject

/// The layers of the board.
@property (nonatomic, strong, readonly) NSMutableArray* layers;

/// The board associated properties.
@property (nonatomic, strong, readonly) NSDictionary* properties;

/**
 * @brief Inits an instance of @b SLTBoard class with the given layers and properties.
 *
 * @param theLayers The layers of the board.
 * @param theProperties The board associated properties.
 * @return The instance of @b SLTBoard class.
 */
- (id) initWithLayers:(NSMutableArray*)theLayers andProperties:(NSDictionary*)theProperties;

/// Regenerates the content of all layers.
- (void) regenerate;

@end
