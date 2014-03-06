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

@class PSLevelBoard;
@class PSCell;
@class PSAssetInChunk;

@interface PSChunk : NSObject

@property (nonatomic, strong, readonly) PSLevelBoard* ownerLevelBoard;
@property (nonatomic, strong, readonly) NSString* chunkId;

- (id)initWithChunkId:(NSString*)theChunkId andOwnerLevelBoard:(PSLevelBoard *)theOwnerLevelBoard;

- (void) addCell:(PSCell*)theCell;

- (void) addChunkAsset:(PSAssetInChunk*)theChunkAsset;

- (void)generate;

@end
