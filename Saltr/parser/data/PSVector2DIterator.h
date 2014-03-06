/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class  PSVector2D;

@interface PSVector2DIterator : NSObject

@property (nonatomic, strong, readonly) PSVector2D* vector2D;

- (id)initVector2DItaratorWithVector:(PSVector2D*)vector2D;

- (BOOL)hasNext;

- (id)nextObject;

- (void)reset;

@end
