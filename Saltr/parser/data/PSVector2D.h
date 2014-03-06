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

@class PSVector2DIterator;

@interface PSVector2D : NSObject

@property (nonatomic, assign, readonly) NSUInteger width;
@property (nonatomic, assign, readonly) NSUInteger height;

- (id)initWithWidth:(NSUInteger)theWidth andHeight:(NSUInteger)theHeight;

- (void)addObject:(id)object atRow:(NSUInteger)row andColumn:(NSUInteger)column;

- (id)retrieveObjectAtRow:(NSUInteger)row andColumn:(NSUInteger)column;

- (PSVector2DIterator*)iterator;

@end
