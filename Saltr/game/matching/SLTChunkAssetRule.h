/*
 * @file SLTChunkAssetRule.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface SLTChunkAssetRule : NSObject

@property(nonatomic, strong, readonly) NSString* assetId;

@property(nonatomic, strong, readonly) NSString* distributionType;

@property(nonatomic, assign, readonly) NSUInteger distributionValue;

@property(nonatomic, strong, readonly) NSArray* stateIds;

- (id)initWithAssetId:(NSString*)theAssetId distributionType:(NSString*)theDistributionType distributionValue:(NSUInteger)theDistributionValue andStateIds:(NSArray*)theStateIds;

@end
