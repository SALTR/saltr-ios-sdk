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
#import "PSCell.h"
#import "PSLevelStructure.h"
#import "PSBoardData.h"
#import "PSCompositeAsset.h"
#import "PSCompositeAssetTemplate.h"

@interface PSComposite() {
    NSDictionary* _boardAssetMap;
}
@end

@implementation PSComposite

@synthesize compositeId = _compositeId;
@synthesize position = _position;
@synthesize ownerLevel = _ownerLevel;

- (id)initWithId:(NSString*)compositeId position:(PSCell*)position andOwnerLevel:(PSLevelStructure*)ownerLevel
{
    self = [super init];
    if (self) {
        _compositeId = compositeId;
        _position = position;
        _ownerLevel = ownerLevel;
        _boardAssetMap = _ownerLevel.boardData.assetMap;
    }
    return  self;
}

- (PSCompositeAsset*)generateAsset
{
    assert(nil != [_boardAssetMap objectForKey:self.compositeId]);
    assert([[_boardAssetMap objectForKey:self.compositeId] isKindOfClass:[PSCompositeAssetTemplate class]]);
    PSCompositeAssetTemplate* compositeAssetTemplate = [_boardAssetMap objectForKey:self.compositeId];
    NSArray* shifts = [compositeAssetTemplate.shifts copy];
    PSCell* basis = [[PSCell alloc] initWithX:self.position.x andY:self.position.y];
    PSCompositeAsset* compositeAsset = [[PSCompositeAsset  alloc] initWithShifts:shifts basis:basis type:compositeAssetTemplate.type andKeys:compositeAssetTemplate.keys];
    return compositeAsset;
}

@end
