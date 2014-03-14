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

@class SLTLevelSettings;

/**
 * @brief This is the interface for @b SLTChunk class.
 *
 * The chunk data is being collected from boards data of JSON:
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
@interface SLTChunk : NSObject

/**
 * @brief Inits an instance of @b SLTChunk class with given chunkCells, chunkAssetInfos and levelSettings
 *
 * @param chunkCells - An array of @b SLTCell pointers to @b SLTCellMatrix board cell objects
 * @param chunkAssetInfos - An array with objects of @b SLTChunkAssetInfo
 * @param theLevelSettings - An instance of @b SLTLevelSettings class which 
 *                           holds an information about asset mapping, state mapping and key set mapping
 *
 * @return - The instance of @b SLTChunk class
 */
- (id)initWithChunkCells:(NSMutableArray*)chunkCells andChunkAssetInfos:(NSMutableArray*)chunkAssetInfos andLevelSettings:(SLTLevelSettings *)theLevelSettings;

/**
 * @brief Generates chunk cells of @b SLTCellMatrix board. Each cell holds a pointer to @b SLTAssetInstance object.
 *
 * Here we differentiate two type of assets : weak, if count equals 0 and strong vice versa.
 * First it fills the strong asset instances randomly into the available cells of matrix, each of them repeats with specified count.
 * The weak assets are being filled in the rest of cells randomly.
 */
- (void)generate;

@end
