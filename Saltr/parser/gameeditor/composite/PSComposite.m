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
#import "PSLevelBoard_Private.h"
#import "PSVector2D.h"

@interface PSComposite() {
    NSDictionary* _boardAssetMap;
}
@end

@implementation PSComposite

@synthesize compositeId = _compositeId;
@synthesize position = _position;
@synthesize ownerLevelBoard = _ownerLevelBoard;

- (id)initWithId:(NSString*)compositeId position:(PSCell*)position andOwnerLevelBoard:(PSLevelBoard *)theOwnerLevelBoard
{
    self = [super init];
    if (self) {
        assert(theOwnerLevelBoard);
        assert(compositeId);
        _compositeId = compositeId;
        _position = position;
        _ownerLevelBoard = theOwnerLevelBoard;
        _boardAssetMap = _ownerLevelBoard.ownerLevel.boardData.assetMap;
    }
    return  self;
}

- (void)generate
{
    assert(nil != [_boardAssetMap objectForKey:self.compositeId]);
    assert([[_boardAssetMap objectForKey:self.compositeId] isKindOfClass:[PSCompositeAssetTemplate class]]);
    PSCompositeAssetTemplate* compositeAssetTemplate = [_boardAssetMap objectForKey:self.compositeId];
    NSArray* shifts = [compositeAssetTemplate.shifts copy];
    PSCell* basis = [[PSCell alloc] initWithX:self.position.x andY:self.position.y];
    PSCompositeAsset* compositeAsset = [[PSCompositeAsset  alloc] initWithShifts:shifts basis:basis type:compositeAssetTemplate.type andKeys:compositeAssetTemplate.keys];
    [_ownerLevelBoard.boardVector addObject:compositeAsset atRow:basis.x andColumn:basis.y];
}

@end
