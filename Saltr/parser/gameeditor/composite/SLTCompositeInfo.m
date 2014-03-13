/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCompositeInfo.h"
#import "SLTCell_Private.h"
#import "SLTLevelSettings.h"
#import "SLTCompositeInstance.h"
#import "SLTCompositeAsset.h"

@interface SLTCompositeInfo() {
    NSString* _stateId;
    SLTCell* _cell;
    NSDictionary* _assetMap;
    NSDictionary* _stateMap;
}
@end

@implementation SLTCompositeInfo

@synthesize assetId = _assetId;

- (id)initWithAssetId:(NSString*)theAssetId stateId:(NSString*)theStateId cell:(SLTCell*)theCell andLevelSettings:(SLTLevelSettings *)theLevelSettings
{
    self = [super init];
    if (self) {
        assert(theLevelSettings);
        assert(theAssetId);
        assert(theStateId);
        _assetId = theAssetId;
        _cell = theCell;
        _stateId = theStateId;
        _assetMap = theLevelSettings.assetMap;
        _stateMap = theLevelSettings.stateMap;
    }
    return  self;
}

- (void)generate
{
    assert(nil != [_assetMap objectForKey:self.assetId]);
    assert([[_assetMap objectForKey:self.assetId] isKindOfClass:[SLTCompositeAsset class]]);
    SLTCompositeAsset* asset = [_assetMap objectForKey:self.assetId];
    NSString* state = [_stateMap objectForKey:_stateId];
    SLTCompositeInstance* compositeAssetInstance = [[SLTCompositeInstance  alloc] initWithCells:asset.cellInfos state:state type:asset.type andKeys:asset.keys];
    _cell.assetInstance = (SLTAssetInstance*)compositeAssetInstance;
}

@end
