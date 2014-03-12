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

@class SLTLevelSettings;
@class SLTCell;
@class SLTChunkAssetInfo;

@interface SLTChunk : NSObject

@property (nonatomic, strong, readonly) NSString* chunkId;

- (id)initWithChunkId:(NSString*)theChunkId andBoardData:(SLTLevelSettings *)theBoardData;

- (void) addCell:(SLTCell*)theCell;

- (void) addChunkAsset:(SLTChunkAssetInfo*)theChunkAsset;

- (void)generate;

@end
