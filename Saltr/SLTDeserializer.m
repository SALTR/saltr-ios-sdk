/*
 * @file SLTDeserializer.m
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
    NSArray* experimentNodes = [data objectForKey:@"experiments"];
    if (experimentNodes) {
        for (NSDictionary* item in experimentNodes) {
            SLTExperiment* experiment = [SLTExperiment new];
            experiment.token = [item objectForKey:@"token"];
            experiment.partition = [item objectForKey:@"partition"];
            experiment.type = [item objectForKey:@"type"];
            experiment.customEvents = [item objectForKey:@"customEventList"];
            [experiments addObject:experiment];
        }
    }
    return experiments;
}

- (NSArray*)decodeLevelsFromData:(NSDictionary *)data
{
    NSMutableArray* levelPackNodes = [data objectForKey:@"levelPacks"];
    NSString* levelType = LEVEL_TYPE_MATCHING;
    
    if ([data objectForKey:@"levelType"]) {
        levelType = [data objectForKey:@"levelType"];
    }
    
    NSMutableArray* levelPacks = [NSMutableArray new];
    
    NSInteger index = -1;
    if (levelPackNodes != nil) {
        //TODO @TIGR: remove this sort when SALTR confirms correct ordering
        NSArray * sortedLevelPackNodes = [levelPackNodes sortedArrayUsingComparator:sortBlockForLevelPackStructure];

        for (NSDictionary* levelPackNode in sortedLevelPackNodes) {
            NSArray* levelNodes  = [levelPackNode objectForKey:@"levels"];
            //TODO @TIGR: remove this sort when SALTR confirms correct ordering
            NSArray* sortedLevelNodes = [levelNodes sortedArrayUsingComparator:sortBlockForLevelStructure];
            
            NSMutableArray* levels = [NSMutableArray new];
            NSInteger packIndex = [[levelPackNode objectForKey:@"index"] integerValue];
            for(NSDictionary* levelNode in sortedLevelNodes) {
                ++index;
                
                //TODO @TIGR: later, leave localIndex only!
                NSInteger localIndex = [[levelNode objectForKey:@"index"] integerValue];
                if ([levelNode objectForKey:@"localIndex"]) {
                    localIndex = [[levelNode objectForKey:@"localIndex"] integerValue];
                }
                [levels addObject:[[SLTLevel alloc] initWithLevelId:[[levelNode objectForKey:@"id"] stringValue] variationId:[[levelNode objectForKey:@"variationId"] stringValue] levelType:levelType index:index localIndex:localIndex packIndex:packIndex contentUrl:[levelNode objectForKey:@"url"] properties:[levelNode objectForKey:@"properties"] andVersion:[levelNode objectForKey:@"version"]]];
            }
            [levelPacks addObject:[[SLTLevelPack alloc] initWithToken:[levelPackNode objectForKey:@"token"] index:packIndex andLevels:levels]];
            
        }
    }
    return levelPacks;
}

- (NSMutableDictionary*)decodeFeaturesFromData:(NSDictionary * )data
{
    NSMutableDictionary* features = [NSMutableDictionary new];
    NSArray* featuresNodes = [data objectForKey:@"features"];
    if (featuresNodes) {
        for (NSDictionary* featureNode in featuresNodes) {
            NSString* token = [featureNode objectForKey:@"token"];
            //TODO @TIGR: remove "data" check later when API versioning is done.
            NSDictionary* properties = [featureNode objectForKey:@"data"];
            if (properties == nil) {
                properties = [featureNode objectForKey:@"properties"];
            }
            SLTFeature* sltFeature = [[SLTFeature alloc] initWithToken:token properties:properties andRequired:[[featureNode objectForKey:@"required"] boolValue]];
            [features setObject:sltFeature forKey:token];
        }
    }
    return features;
}

#pragma mark private functions

NSComparisonResult (^sortBlockForLevelPackStructure)(id, id) = ^(NSDictionary* obj1, NSDictionary* obj2) {
    if ([[obj1 objectForKey:@"index"] integerValue]  > [[obj2 objectForKey:@"index"] integerValue] ) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([[obj1 objectForKey:@"index"] integerValue]  < [[obj2 objectForKey:@"index"] integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

NSComparisonResult (^sortBlockForLevelStructure)(id, id) = ^(NSDictionary* obj1, NSDictionary* obj2) {
    if ([[obj1 objectForKey:@"index"] integerValue] > [[obj2 objectForKey:@"index"] integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([[obj1 objectForKey:@"index"] integerValue]  < [[obj2 objectForKey:@"index"] integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};


@end
