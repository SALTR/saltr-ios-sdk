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

@class SLTCellMatrix;

/**
 * The public interface of game @b SLTLevelBoard class.
 */

@interface SLTLevelBoard : NSObject

/// The rows of level board
@property (nonatomic, assign, readonly) NSUInteger rows;

/// The columns of level board matrix
@property (nonatomic, assign, readonly) NSUInteger cols;

/// The board matrix of @b SLTCellMatrix type
@property (nonatomic, strong, readonly) SLTCellMatrix* cells;

/// The map of board properties
@property (nonatomic, strong, readonly) NSDictionary* properties;

/**
 * @brief Initializes the instance of @b SLTLevelBoard class.
 * 
 * @param theCells - matrix of cells with assets
 * @param theProperties - properties of level board
 * @return - the instance of @b SLTLevelBoard class
 */
- (id) initWithCellMatrix:(SLTCellMatrix*)theCells andProperties:(NSDictionary*)theProperties;

@end
