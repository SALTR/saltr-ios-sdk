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
#import "SLTAsset.h"

/**
 * @brief This is the interface of @b SLTCompositeAsset class.
 *
 * This class holds the composite asset information of cells, type and keys, which are being extracted from asset.
 * If asset of "assets" in the JSON data has cell property, this means that it is composite asset.
 *
 * The composite asset instances will be stored in the cells (mentioned in asset) of board matrix.
 *
 *  "boards": {
 *      "main": {
 *             "composites": [ {
 *                      "assetId": 2839,
 *                      "position": [0, 10]
 *                      }, ....
 *              ],
 *              "chunks": [...],
 *              "blockedCells": ...
 *              "properties": {
 *                  "cell" : [{...}]
 *               }
 *       }
 *   }
 *   ...
 *  "assets": {
 *      "2839": {
 *          "cells": [[0, 0],..., [0, 10], [1, 16]]
 *          "keys": {
 *                  "COLOR": 1,
 *                  "CARD_SUIT": 1,
 *                  "CARD_VALUE": 1
 *                  },
 *          "states": [
 *                       534
 *                     ],
 *          "type_key": "normal"
 *
 *       },
 *  }
 */

@interface SLTCompositeAsset : SLTAsset

/// The list of cells of board matrix, where the composite asset instances will be stored.
@property (nonatomic, strong, readonly) NSArray* cellInfos;

/**
 * @brief Inits an instance of @b SLTCompositeAsset class with given cellInfos, type and keys
 *
 * @param theCellInfos - The list of cells of board matrix, where the composite asset instances will be stored
 * @param theType - the type of @b SLTCompositeAsset
 * @param theKeys - the keys of @b SLTCompositeAsset
 *
 * @return - The instance of @b @b SLTCompositeAsset class
 */
- (id)initWithCellInfos:(NSArray*)theCellInfos type:(NSString*)theType andKeys:(NSDictionary*)theKeys;

@end
