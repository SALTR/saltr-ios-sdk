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

@class SLTCell;
@class SLTLevelSettings;

/**
 * @brief This is the interface of @b SLTCompositeInfo class.
 *
 * This class holds the information of composite asset, which is being extracted from a corresponding composite of the "composites" node of JSON:
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

@interface SLTCompositeInfo : NSObject

/// Id of composite asset
@property (nonatomic, strong, readonly) NSString* assetId;

/**
 * @brief Inits an instance of @b SLTChunkAssetInfo class with given chunkCells, chunkAssetInfos and levelSettings
 *
 * @param theAssetId - the id of @b SLTCompositeInfo instance
 * @param theStateId - the state of @b SLTCompositeInfo
 * @param theCell - the cell from the list of composite assets cellsInfo, where the @b SLTCompositeInstance will be stored
 * @param theLevelSettings - An instance of @b SLTLevelSettings class, which
 *                           holds an information about asset mapping, state mapping and key set mapping
 *
 * @return - The instance of @b SLTChunkAssetInfo class
 */
- (id)initWithAssetId:(NSString*)theAssetId stateId:(NSString*)theStateId cell:(SLTCell*)theCell andLevelSettings:(SLTLevelSettings *)theLevelSettings;

/// Generates an instance of @b SLTCompositeAssetInstance type for the specified cell of matrix board.
- (void)generate;

@end
