/*
 * @file SLTExperiment.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/**
 * Specifies the Feature type for the experiment.
 */
#define SPLIT_TEST_TYPE_FEATURE @"FEATURE"

/**
 * Specifies the LevelPack type for the experiment.
 */
#define SPLIT_TEST_TYPE_LEVEL_PACK @"LEVEL_PACK"

/// <summary>
/// The SLTExperiment class provides the currently running experiment data.
/// It is possible to A/B test any feature included in the game AND/OR different levels, level packs.
/// </summary>
@interface SLTExperiment : NSObject

/// The letter of the partition in which the user included in (A, B, C, etc.).
@property (nonatomic, strong) NSString* partition;

/// The unique identifier of the experiment.
@property (nonatomic, strong) NSString* token;

/// The type of the experiment (Feature or LevelPack).
@property (nonatomic, strong) NSString* type;

/// The array of comma separated event names for which A/B test data should be send.
@property (nonatomic, strong) NSArray* customEvents;

/**
 * @brief Inits the instance of @b SLTExperiment class with the token, partition, type and custom events.
 *
 * @param theToken The unique identifier of the experiment.
 * @param thePartition The letter of the partition in which the user included in (A, B, C, etc.).
 * @param theType The type of the experiment (Feature or LevelPack).
 * @param theCustomEvents The array of comma separated event names for which A/B test data should be send.
 */
- (id)initWithToken:(NSString*)theToken partition:(NSString*)thePartition type:(NSString*)theType andCustomEvents:(NSArray*)theCustomEvents;

@end
