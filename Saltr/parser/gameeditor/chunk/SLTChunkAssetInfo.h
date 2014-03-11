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

@interface SLTChunkAssetInfo : NSObject

@property (nonatomic, strong, readonly) NSString* assetId;
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) NSString* stateId;

- (id)initWithAssetId:(NSString*)theAssetId count:(NSUInteger)theCount andStateId:(NSString*)theStateId;

@end
