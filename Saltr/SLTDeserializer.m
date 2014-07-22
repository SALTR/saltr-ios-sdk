/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTDeserializer.h"
#import "SLTExperiment.h"
#import "SLTLevelPack.h"
#import "SLTLevel.h"
#import "SLTFeature.h"

@implementation SLTDeserializer


- (NSArray*)decodeExperimentsFromData:(NSDictionary *)data
{
    NSMutableArray* experiments = [NSMutableArray new];
    NSArray* experimentInfo = [data objectForKey:@"splitTestInfo"];
    if (experimentInfo) {
        for (NSDictionary* item in experimentInfo) {
            SLTExperiment* experiment = [SLTExperiment new];
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
    if ([data objectForKey:@"responseData"]) {
        data = [data objectForKey:@"responseData"];
    }
    NSMutableArray* levelPacks = [data objectForKey:@"levelPackList"];
    NSMutableArray* levelPackStructures = [NSMutableArray new];
    for (NSDictionary* levelPack in levelPacks) {
        NSArray* levels  = [levelPack objectForKey:@"levelList"];
        NSMutableArray* levelStructures = [NSMutableArray new];
        for (NSDictionary* level in levels) {
            //TODO: @TIGR correct
            //[levelStructures addObject:[[SLTLevel alloc] initWithLevelId:[[level objectForKey: @"id"] stringValue] index:[[level objectForKey: @"order"] stringValue] contentDataUrl:[level objectForKey: @"url"] properties:[level objectForKey: @"properties"] andVersion:[[level objectForKey: @"version"] stringValue]]];
        }
        //TODO: @TIGR correct
        //NSArray *sortedLevelStructures = [levelStructures sortedArrayUsingComparator:sortBlockForLevelStructure];
        //[levelPackStructures addObject:[[SLTLevelPack alloc] initWithToken:[levelPack objectForKey:@"token"] levels:sortedLevelStructures andIndex:[[levelPack objectForKey:@"order"] stringValue]]];
    }
    NSArray *sortedLevelPackStructures = [levelPackStructures sortedArrayUsingComparator:sortBlockForLevelPackStructure];
    return sortedLevelPackStructures;
}

- (NSDictionary*)decodeFeaturesFromData:(NSDictionary * )data
{
    NSMutableDictionary* features = [NSMutableDictionary new];
    NSArray* featuresList = [data objectForKey:@"featureList"];
    if (featuresList) {
        for (NSDictionary* feature in featuresList) {
            if (feature) {
                NSString* token = [feature objectForKey:@"token"];
                if (token) {
                    SLTFeature* sltFeature = [[SLTFeature alloc] initWithToken:token defaultProperties:nil andProperties:[feature objectForKey:@"data"]];
                    assert(sltFeature);
                    [features setObject:sltFeature forKey:token];
                }
            }
        }
    }
    return features;
}

#pragma mark private functions

NSComparisonResult (^sortBlockForLevelPackStructure)(id, id) = ^(SLTLevelPack* obj1, SLTLevelPack* obj2) {
    if ([obj1 index]  > [obj2 index] ) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 index]  < [obj2 index]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

NSComparisonResult (^sortBlockForLevelStructure)(id, id) = ^(SLTLevel* obj1, SLTLevel* obj2) {
    if ([obj1 index] > [obj2 index]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 index]  < [obj2 index]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};


@end
