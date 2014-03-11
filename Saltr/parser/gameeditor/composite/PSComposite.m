/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSComposite.h"
#import "SLTCell_Private.h"
#import "SLTLevelSettings.h"
#import "PSCompositeInstance.h"
#import "SLTCompositeAsset.h"

@interface PSComposite() {
    NSDictionary* _boardAssetMap;
}
@end

@implementation PSComposite

@synthesize compositeId = _compositeId;
@synthesize cell = _cell;

- (id)initWithId:(NSString*)theCompositeId cell:(SLTCell*)theCell andBoardData:(SLTLevelSettings *)theBoardData
{
    self = [super init];
    if (self) {
        assert(theBoardData);
        assert(theCompositeId);
        _compositeId = theCompositeId;
        _cell = theCell;
        _boardAssetMap = theBoardData.assetMap;
    }
    return  self;
}

- (void)generate
{
    assert(nil != [_boardAssetMap objectForKey:self.compositeId]);
    assert([[_boardAssetMap objectForKey:self.compositeId] isKindOfClass:[SLTCompositeAsset class]]);
    SLTCompositeAsset* compositeAsset = [_boardAssetMap objectForKey:self.compositeId];
    PSCompositeInstance* compositeAssetInstance = [[PSCompositeInstance  alloc] initWithShifts:compositeAsset.shifts type:compositeAsset.type andKeys:compositeAsset.keys];
    _cell.assetInstance = (SLTAssetInstance*)compositeAssetInstance;
}

@end
