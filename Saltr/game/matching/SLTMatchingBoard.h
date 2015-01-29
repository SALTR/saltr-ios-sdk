/*
 * @file SLTMatchingBoard.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoard.h"

@class SLTCells;

/// <summary>
/// The SLTMatchingBoard class represents the matching game board.
/// </summary>
@interface SLTMatchingBoard : SLTBoard

/// The cells of the board.
@property(nonatomic, strong, readonly) SLTCells* cells;

/// The number of rows.
@property(nonatomic, assign, readonly) NSInteger rows;

/// The number of columns.
@property(nonatomic, assign, readonly) NSInteger cols;

/**
 * @brief Inits an instance of @b SLTMatchingBoard class with the given cells, layers and properties.
 *
 * @param theCells The cells of the board.
 * @param theLayers The layers of the board.
 * @param theProperties The board associated properties.
 * @return @return The instance of @b SLTMatchingBoard class.
 */
-(id) initWithCells:(SLTCells*)theCells layers:(NSMutableArray *)theLayers andProperties:(NSDictionary *)theProperties;

@end
