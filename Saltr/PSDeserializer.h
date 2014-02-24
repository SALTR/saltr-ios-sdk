//
//  PSDeserializer.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSDeserializer : NSObject

/**
 * @brief Decodes and creates an array of Expoeriment objects corresponding to data
 * 
 * @param data - data object corresponding to JSON
 * @return - array of experiments
 */
+ (NSArray*)decodeExperimentsFromData:(id)data;

/**
 * @brief Decodes and creates an array of LevelPackStructure objects corresponding to data
 *
 * @param data - data object corresponding to JSON
 * @return - array of experiments
 */
+ (NSArray*)decodeLevelsFromData:(id)data;

/**
 * @brief Decodes and creates an dictionary of Feature objects corresponding to data
 *
 * @param data - data object corresponding to JSON
 * @return - array of Feature objects
 */
+ (NSDictionary*)decodeFeaturesFromData:(id)data;


@end
