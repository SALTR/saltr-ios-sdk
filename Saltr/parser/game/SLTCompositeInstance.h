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
#import "SLTAssetInstance.h"

/**
 * @brief This is public interface of @b SLTCompositeInstance class.
 *
 * An instance of this class holds the basic asset data (type, keys, state) and the list of board cells, where composite instances are stored.
 * The instance is stored in the corresponding cell of board matrix.
 */
@interface SLTCompositeInstance : SLTAssetInstance

/// The list of cells of board matrix, where the composite asset instances are stored.
@property (nonatomic, strong, readonly) NSArray* cells;

/**
 * @brief Inits an instance of @b SLTCompositeInstance class with given cellInfos, type and keys
 *
 * @param theCells - The list of cells of board matrix, where the composite asset instances are stored
 * @param theState - The state of @b SLTCompositeInstance
 * @param theType - the type of @b SLTCompositeInstance
 * @param theKeys - the keys of @b SLTCompositeInstance
 *
 * @return - The instance of @b @b SLTCompositeInstance class
 */
- (id)initWithCells:(NSArray*)theCells state:(NSString*)theState type:(NSString*)theType andKeys:(NSDictionary*)theKeys;

@end
