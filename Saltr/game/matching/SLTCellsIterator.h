/*
 * @file SLTCellsIterator.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class SLTCell;
@class SLTCells;

/// <summary>
/// The SLTCellsIterator class represents an iterator for SLTCells class.
/// </summary>
@interface SLTCellsIterator : NSObject

/**
 * @brief Inits an instance of @b SLTCellsIterator class with the given cells.
 *
 * @param theCells The cells to iterate on.
 */
-(id) initWithCells:(SLTCells*)theCells;

/**
 * Returns <code>true</code> if the iteration has more elements.
 * @return <code>true</code> if the iteration has more elements.
 */
-(BOOL) hasNext;

/**
 * Return the next element in the iteration.
 * @return SLTCell The next element in the iteration.
 */
-(SLTCell*) next;

/**
 * Resets iterator to first element.
 */
-(void) reset;

@end
