/*
 * @file SLTDeserializer.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/**
 * @brief @b SLTDeserializer class decodes and initializes the following objects : 
 *   1. @b the list of SLTExperiment
 *   2. @b the list of SLTLevelPackStructure
 *   3. @b the list of SLTLevelStructure
 *   4. @b the list of features
 */
@interface SLTDeserializer : NSObject

/**
 * @brief Decodes and creates an array of Expoeriment objects corresponding to data
 * 
 * @param data - data object corresponding to JSON
 * @return - array of experiments
 */
- (NSArray*)decodeExperimentsFromData:(NSDictionary *)data;

/**
 * @brief Decodes and creates an array of LevelPackStructure objects corresponding to data
 *
 * @param data - data object corresponding to JSON
 * @return - array of experiments
 */
- (NSArray*)decodeLevelsFromData:(NSDictionary *)data;

/**
 * @brief Decodes and creates an dictionary of Feature objects corresponding to data
 *
 * @param data - data object corresponding to JSON
 * @return - array of Feature objects
 */
- (NSMutableDictionary*)decodeFeaturesFromData:(NSDictionary *)data;


@end
