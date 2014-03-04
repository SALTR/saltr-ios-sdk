/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSCompositeAssetTemplate.h"

@implementation PSCompositeAssetTemplate

@synthesize shifts = _shifts;

- (id)initWithShifts:(NSArray*)shifts typeKey:(NSString*)typeKey andKeys:(NSDictionary*)keys
{
    self = [super initWithTypeKey:typeKey andKeys:keys];
    if (self) {
        _shifts = shifts;
    }
    return  self;
}

@end
