/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class  SLTCell;
@class  SLTCellMatrix;

/**
 * @brief This is a public interface of @b SLTCellMatrixIterator class.
 *
 * This class provides an interface to iterate through the elements of @b SLTCellMatrix.
 */
@interface SLTCellMatrixIterator : NSObject

/**
 * @brief Inits the instance of @b SLTCellMatrixIterator class
 *
 * @param matrix - An object of @b SLTCellMatrix class
 * @return - The instance of @b SLTCellMatrixIterator class
 */
- (id)initWithCellMatrix:(SLTCellMatrix*)matrix;

/// Returns true in case the iterator does not stand on the last element of matrix, otherwise returns false.
- (BOOL)hasNext;

/// Returns the next @b SLTCell element of the matrix
- (SLTCell*)next;

/// Resets the iterator to stand on the start [0,0] position
- (void)reset;

@end
