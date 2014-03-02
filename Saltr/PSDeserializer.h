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

@interface PSDeserializer : NSObject

/**
 * @brief Decodes and creates an array of Expoeriment objects corresponding to data
 * 
 * @param data - data object corresponding to JSON
 * @return - array of experiments
 */
- (NSArray*)decodeExperimentsFromData:(id)data;

/**
 * @brief Decodes and creates an array of LevelPackStructure objects corresponding to data
 *
 * @param data - data object corresponding to JSON
 * @return - array of experiments
 */
- (NSArray*)decodeLevelsFromData:(id)data;

/**
 * @brief Decodes and creates an dictionary of Feature objects corresponding to data
 *
 * @param data - data object corresponding to JSON
 * @return - array of Feature objects
 */
- (NSDictionary*)decodeFeaturesFromData:(id)data;


@end
