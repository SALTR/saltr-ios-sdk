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

@class SLTCellMatrixIterator;
@class SLTCell;

/**
 * @brief This is a public interface of @b SLTCellMatrix class.
 *
 * An instance of this class represents the 2-dimensional array of @b SLTCell objects.
 * Each intance of the class provides also the @b SLTCellMatrixIterator type iterator to iterate the matrix elements.
 */
@interface SLTCellMatrix : NSObject

/// The width of the matrix (columns count)
@property (nonatomic, assign, readonly) NSUInteger width;

/// The height of the matrix (rows count)
@property (nonatomic, assign, readonly) NSUInteger height;

/**
 * @brief Inits an instance of @b SLTCellMatrix class with given width and height,
 * filling NSNull objects instead of each object.
 *
 * @param theWidth - the columns count of the matrix
 * @param theHeight - the rows count of the matrix
 * @return - The instance of @b SLTCellMatrix class
 */
- (id)initWithWidth:(NSUInteger)theWidth andHeight:(NSUInteger)theHeight;

/**
 * @brief Inserts @b SLTCell object into the matrix with the (row, column) position.
 * If there is already an element inserted into the matrix with the same position,
 * the latter will be replace with the given one.
 *
 * @param cell - the @b SLTCell object, that will be inserted into matrix.
 * @param row - the row index
 * @param column - the column index
 */
- (void)insertCell:(SLTCell*)cell atRow:(NSUInteger)row andColumn:(NSUInteger)column;

/**
 * @brief Retrieves @b SLTCell object from the matrix with the (row, column) position.
 *
 * @param row - the row index
 * @param column - the column index
 * @return - The @b SLTCell object
 */
- (id)retrieveCellAtRow:(NSUInteger)row andColumn:(NSUInteger)column;

/**
 * @brief Initilizes once and returns the @b SLTCellMatrixIterator instance to iterate the matrix object.
 *
 * @return - The @b SLTCellMatrixIterator instance
 */
- (SLTCellMatrixIterator*)iterator;

@end
