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

@class PSCell;
@class PSCompositeAsset;
@class PSLevelStructure;

@interface PSComposite : NSObject

@property (nonatomic, strong, readonly) PSLevelStructure* ownerLevel;
@property (nonatomic, strong, readonly) NSString* compositeId;
@property (nonatomic, strong, readonly) PSCell* position;
@property (nonatomic, strong, readonly) NSDictionary* boardAssetMap;

- (id)initWithId:(NSString*)compositeId position:(PSCell*)position andOwnerLevel:(PSLevelStructure*)ownerLevel;

- (PSCompositeAsset*)generateAsset;

@end
