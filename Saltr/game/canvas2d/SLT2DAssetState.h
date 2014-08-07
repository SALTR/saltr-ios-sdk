/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTAssetState.h"

@interface SLT2DAssetState : SLTAssetState


/// The pivot x.
@property (nonatomic, strong, readonly) NSNumber* pivotX;

/// The pivot y.
@property (nonatomic, strong, readonly) NSNumber* pivotY;

- (id)initWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties pivotX:(NSNumber *)thePivotX andPivotY:(NSNumber *)thePivotY;

@end
