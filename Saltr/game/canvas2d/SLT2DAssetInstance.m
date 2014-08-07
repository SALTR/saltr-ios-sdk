/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLT2DAssetInstance.h"

@implementation SLT2DAssetInstance

@synthesize x = _x;
@synthesize y = _y;
@synthesize rotation = _rotation;

- (id)initWithToken:(NSString *)theToken states:(NSMutableArray *)theStates properties:(NSDictionary *)theProperties x:(NSNumber *)theX y:(NSNumber *)theY andRotation:(NSNumber *)theRotation
{
    self = [super initWithToken:theToken states:theStates andProperties:theProperties];
    if (self) {
        _x = theX;
        _y = theY;
        _rotation = theRotation;
    }
    return self;
}

@end
