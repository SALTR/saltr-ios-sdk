/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSDeserializer.h"
#import "PSExperiment.h"
#import "PSLevelPackStructure.h"
#import "PSLevelStructure.h"
#import "PSFeature.h"

@implementation PSDeserializer


- (NSArray*)decodeExperimentsFromData:(NSDictionary *)data
{
    NSMutableArray* experiments = [NSMutableArray new];
    /// @todo should be checked whether dictionary has @"experimentInfo" key
    NSArray* experimentInfo = [data objectForKey:@"experimentInfo"];
    if (experimentInfo) {
        for (id item in experimentInfo) {
            PSExperiment* experiment = [PSExperiment new];
            experiment.token = [item objectForKey:@"token"];
            experiment.partition = [item objectForKey:@"partitionName"];
            experiment.type = [item objectForKey:@"type"];
            experiment.customEvents = [item objectForKey:@"customEventList"];
            [experiments addObject:experiment];
        }
    }
    return experiments;
}

- (NSArray*)decodeLevelsFromData:(NSDictionary *)data
{
    NSMutableArray* levelPacks = [data objectForKey:@"levelPackList"];
    NSMutableArray* levelPackStructures = [NSMutableArray new];
    for (PSLevelPackStructure* levelPack in levelPacks) {
        NSArray* levels  = levelPack.levelStructureList;
        NSMutableArray* levelStructures = [NSMutableArray new];
        for (PSLevelStructure* level in levels) {
            /// clarify - @todo @b PSLevelStructure does not have order property
            [levelStructures addObject:[[PSLevelStructure alloc] initWithLevelId:level.levelId index:level.index dataUrl:level.dataUrl properties:level.properties andVersion:level.version]];
        }
        NSArray *sortedLevelStructures = [levelStructures sortedArrayUsingComparator:sortBlockForLevelStructure];
        [levelPackStructures addObject:[[PSLevelPackStructure alloc] initWithToken:levelPack.token levelStructureList:sortedLevelStructures andIndex:levelPack.index]];
    }
    NSArray *sortedLevelPackStructures = [levelPackStructures sortedArrayUsingComparator:sortBlockForLevelPackStructure];
    return sortedLevelPackStructures;
}

- (NSDictionary*)decodeFeaturesFromData:(NSDictionary * )data
{
    NSMutableDictionary* features = [NSMutableDictionary new];
    NSArray* featuresList = [data objectForKey:@"featureList"];
    if (featuresList) {
        for (PSFeature* feature in featuresList) {
            [features setObject:[[PSFeature alloc] initWithToken:feature.token defaultProperties:nil andProperties:feature.properties] forKey:feature.token];
        }
    }
    return features;
}

#pragma mark private functions

NSComparisonResult (^sortBlockForLevelPackStructure)(id, id) = ^(PSLevelPackStructure* obj1, PSLevelPackStructure* obj2) {
    if ([obj1 index] > [obj2 index]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 index] < [obj2 index]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

NSComparisonResult (^sortBlockForLevelStructure)(id, id) = ^(PSLevelStructure* obj1, PSLevelStructure* obj2) {
    if ([obj1 index] > [obj2 index]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 index] < [obj2 index]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

@end
