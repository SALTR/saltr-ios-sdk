/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLT2DAssetState.h"

@implementation SLT2DAssetState

@synthesize pivotX = _pivotX;
@synthesize pivotY = _pivotY;

- (id)initWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties pivotX:(NSNumber *)thePivotX andPivotY:(NSNumber *)thePivotY
{
    self = [super initWithToken:theToken andProperties:theProperties];
    if (self) {
        _pivotX = thePivotX;
        _pivotY = thePivotY;
    }
    return self;
}

@end
