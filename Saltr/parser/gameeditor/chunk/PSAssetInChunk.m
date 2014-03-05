/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSAssetInChunk.h"

@implementation PSAssetInChunk

@synthesize assetId = _assetId;
@synthesize count = _count;
@synthesize stateId = _stateId;

- (id)initWithAssetId:(NSString*)theAssetId count:(NSUInteger)theCount andStateId:(NSString*)theStateId
{
    self = [super init];
    if (self) {
        assert(nil != theAssetId);
        _assetId = theAssetId;
        _count = theCount;
        _stateId = theStateId;
    }
    return self;
}

@end
