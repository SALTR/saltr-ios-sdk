/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCompositeInstance.h"

@implementation SLTCompositeInstance

@synthesize cells = _cells;

- (id)initWithCells:(NSArray*)theCells state:(NSString*)theState type:(NSString*)theType andKeys:(NSDictionary*)theKeys
{
    self = [super initWithState:theState type:theType andKeys:theKeys];
    if (self) {
        _cells = theCells;
    }
    return self;
}

- (NSString *)description
{
    NSString* superDescription = [super description];
    return [NSString stringWithFormat: @"PSCompositeAssetInstance : [cells : %@], %@ ", self.cells, superDescription];
}

@end
