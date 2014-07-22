/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTChunkAssetRule.h"

@implementation SLTChunkAssetRule

@synthesize assetId =  _assetId;

@synthesize distributionType = _distributionType;

@synthesize distributionValue = _distributionValue;

@synthesize stateIds = _stateIds;

- (id)initWithAssetId:(NSString*)theAssetId distributionType:(NSString*)theDistributionType distributionValue:(NSUInteger)theDistributionValue andStateIds:(NSArray*)theStateIds
{
    self = [super init];
    if (self) {
        _assetId = theAssetId;
        _distributionType = theDistributionType;
        _distributionValue = theDistributionValue;
        _stateIds = theStateIds;
    }
    return self;
}

@end
