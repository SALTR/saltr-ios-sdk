/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSCell_Private.h"

@implementation PSCell

@synthesize x = _x;
@synthesize y = _y;
@synthesize isBlocked = _isBlocked;
@synthesize properties = _properties;
@synthesize assetInstance = _assetInstance;

-(id) initWithX:(NSInteger)x andY:(NSInteger)y
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
        _properties = [NSMutableDictionary new];
        _isBlocked = false;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"[coords: (%i , %i)], [isblocked: %i], [properties: %@], [assetInstance: %@]", self.x, self.y, self.isBlocked,self.properties, self.assetInstance];
}

@end
