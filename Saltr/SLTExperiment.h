/*
 * @file
 * SLTExperiment.h
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

#define SPLIT_TEST_TYPE_FEATURE @"FEATURE"
#define SPLIT_TEST_TYPE_LEVEL_PACK @"LEVEL_PACK"

/**
 * The public interface of game @b SLTExperiment class.
 */
@interface SLTExperiment : NSObject

/// Partition of experiment
@property (nonatomic, strong) NSString* partition;

/// Token of experiment
@property (nonatomic, strong) NSString* token;

/// Type of experiment
@property (nonatomic, strong) NSString* type;

/// Custom events of experiment.
///@todo At this moment this property is unused.
@property (nonatomic, strong) NSArray* customEvents;

/**
 * @brief Inits the instance of @b SLTExperiment class with the token, partition and type
 *
 * @param theToken - token of experiment
 * @param thePartition - partition of experiment
 * @param theType - type of experiment
 * @param theCustomEvents - custom events
 * @return - The instance of @b SLTExperiment class
 */
- (id)initWithToken:(NSString*)theToken partition:(NSString*)thePartition type:(NSString*)theType andCustomEvents:(NSArray*)theCustomEvents;

@end
