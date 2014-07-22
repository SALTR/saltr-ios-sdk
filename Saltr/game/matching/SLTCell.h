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

@class SLTAssetInstance;

/**
 * @brief This is the public interface for @b SLTCell class.
 *
 * The instance of this class is the single cell of baord matrix.
 * In general it holds an instance of @b SLTAssetInstance class or an instance of its derived @b SLTCompositeInstance class.
 *
 * The cell data is being collected from composite and asset data of JSON:
 *
 * {
 *  "assetStates": {
 *          "534": "state1",
 *          "535": "state2"
 *  },
 *  ...
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
 *  "assets": {
 *      "2835": {...
 *       },
 *  }
 * }
 */

@interface SLTCell : NSObject

/// The column of the cell in board matrix
@property (nonatomic, assign, readwrite) NSUInteger col;

/// The row of the cell in board matrix
@property (nonatomic, assign, readwrite) NSUInteger row;

/// Shows whether the cell is blocked
@property (nonatomic, assign, readwrite) BOOL isBlocked;

/// The properties of the cell
@property (nonatomic, strong, readwrite) NSDictionary* properties;

/**
 * @brief Inits an instance of @b SLTCell class with the given X and Y coordinates
 *
 * @param col - the column of cell
 * @param row - the row of cell
 * @return - The instance of @b SLTCell class
 */
-(id) initWithCol:(NSInteger)col andRow:(NSInteger)row;

-(SLTAssetInstance*) getAssetInstanceByLayerId:(NSString*)layerId;

-(SLTAssetInstance*) getAssetInstanceByLayerIndex:(NSInteger)layerIndex;

-(void) setAssetInstanceByLayerId:(NSString*)theLayerId layerIndex:(NSInteger)theLayerIndex andAssetInstance:(SLTAssetInstance*)theAssetInstance;

-(void) removeAssetInstanceByLayerId:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex;

@end