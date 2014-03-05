/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSSimpleAsset.h"

@implementation PSSimpleAsset

@synthesize state = _state;
@synthesize cell = _cell;

- (id)initWithState:(NSString*)state cell:(PSCell*)cell type:(NSString*)theType andKeys:(NSDictionary*)theKeys
{
    self = [super initWithType:theType andKeys:theKeys];
    if (self) {
    }
    return self;
}

@end
