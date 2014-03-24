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

/**
 * @brief This is the interface of @b SLTChunkAssetInfo class.
 *
 * This class holds an assets information, which is being collected from boards data of JSON:
 *
 *  "boards": {
 *      "main": {
 *             "composites": [ {
 *                      "assetId": 2839,
 *                      "position": [0, 10]
 *                  } ],
 *              "chunks": [ {
 *                       "chunkId": 1,
 *                       "assets": [{
 *                          "assetId": "2836",
 *                          "count": 0,
 *                          "stateId": 534
 *                      },...],
 *                      "cells": [[ 9, 5 ], [ 10, 5 ],..]
 *               }],
 *              "blockedCells": [[ 3, 1], [4,1]],
 *              "properties": {
 *                  "cell" : [{...}]
 *               }
 *       }
 *   }
 */
@interface SLTChunkAssetInfo : NSObject

/// The id of @b SLTChunkAssetInfo object
@property (nonatomic, strong, readonly) NSString* assetId;

/**
 * @brief The count of repeatitions of asset in the chunk cells of board matrix.
 * If the count == 0, the asset is weak, otherwise strong.
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/// The state of @b SLTChunkAssetInfo
@property (nonatomic, strong, readonly) NSString* stateId;

/**
 * @brief Inits an instance of @b SLTChunkAssetInfo class with given chunkCells, chunkAssetInfos and levelSettings
 *
 * @param theAssetId - the id of @b SLTChunkAssetInfo instance
 * @param theCount - the count of repeatitions of asset in the chunk cells of board matrix
 * @param theStateId - the state of @b SLTChunkAssetInfo
 *
 * @return - The instance of @b SLTChunkAssetInfo class
 */
- (id)initWithAssetId:(NSString*)theAssetId count:(NSUInteger)theCount andStateId:(NSString*)theStateId;

@end
