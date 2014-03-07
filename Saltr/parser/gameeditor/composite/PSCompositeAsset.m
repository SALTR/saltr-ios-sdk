/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSCompositeAsset.h"

@implementation PSCompositeAsset

@synthesize shifts = _shifts;

- (id)initWithShifts:(NSArray*)shifts type:(NSString*)theType andKeys:(NSDictionary*)theKeys
{
    self = [super initWithType:theType andKeys:theKeys];
    if (self) {
        _shifts = shifts;
    }
    return  self;
}

- (NSString *)description
{
    NSString* superDescription = [super description];
    return [NSString stringWithFormat: @"PSCompositeAsset : [shifts : %@], %@ ", self.shifts, superDescription];
}

@end
