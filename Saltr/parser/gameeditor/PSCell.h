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

@class PSAssetInstance;

@interface PSCell : NSObject

@property (nonatomic, assign, readonly) NSInteger x;
@property (nonatomic, assign, readonly) NSInteger y;
@property (nonatomic, assign, readonly) BOOL isBlocked;
@property (nonatomic, strong, readonly) NSDictionary* properties;
@property (nonatomic, strong, readonly) PSAssetInstance* assetInstance;

-(id) initWithX:(NSInteger)x andY:(NSInteger)y;

@end