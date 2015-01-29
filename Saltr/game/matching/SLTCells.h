/*
 * @file SLTCells.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class SLTCell;
@class SLTCellsIterator;

/// <summary>
/// The SLTCells class provides convenient access to board cells.
/// </summary>
@interface SLTCells : NSObject

/// The number of columns.
@property(nonatomic, assign, readonly) NSInteger width;

/// The number of rows.
@property(nonatomic, assign, readonly) NSInteger height;

/// The cells iterator.
@property(nonatomic, strong, readonly) SLTCellsIterator* iterator;

//TODO: tigr the funciton below shuld be internal
@property(nonatomic, strong, readonly) NSMutableArray* rawData;

/**
 * @brief Inits an instance of @b SLTCells class with the given width and height.
 
 * @param theWidth The number of columns.
 * @param theHeight The number of rows.
 * @return The instance of @b SLTCells class.
 */
-(id) initWithWidth:(NSInteger)theWidth andHeight:(NSInteger)theHeight;

/**
 * Inserts cell at given column and row.
 * @param theCell The cell.
 * @param theCol The column.
 * @param theRow The row.
 */
-(void) insertCell:(SLTCell*)theCell atCol:(NSInteger)theCol andRow:(NSInteger)theRow;

/**
 * Retrieves the cell specified by column and row.
 * @param theCol The column.
 * @param theRow The row.
 * @return SLTCell The cell at given col and row.
 */
-(SLTCell*) retrieveCellAtCol:(NSInteger)theCol andRow:(NSInteger)theRow;

@end
