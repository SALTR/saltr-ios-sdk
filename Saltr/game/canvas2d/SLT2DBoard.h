/*
 * @file SLT2DBoard.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoard.h"

/// <summary>
/// The SLT2DBoard class represents the 2D game board.
/// </summary>
@interface SLT2DBoard : SLTBoard

/// The width of the board in pixels as is in Saltr level editor.
@property (nonatomic, strong, readonly) NSNumber* width;

/// The height of the board in pixels as is in Saltr level editor.
@property (nonatomic, strong, readonly) NSNumber* height;

/**
 * @brief Inits an instance of @b SLT2DBoard class with the given width, height, layers and properties.
 *
 * @param theWidth The width of the board in pixels as is in Saltr level editor.
 * @param theHeight The height of the board in pixels as is in Saltr level editor.
 * @param theLayers The layers of the board.
 * @param theProperties The board associated properties.
 * @return The instance of @b SLT2DBoard class.
 */
- (id) initWithWidth:(NSNumber * )theWidth theHeight:(NSNumber *)theHeight layers:(NSMutableArray*)theLayers andProperties:(NSDictionary*)theProperties;

@end
