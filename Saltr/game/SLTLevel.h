/*
 * @file SLTLevel.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/**
 * Specifies that there is no level specified for the game.
 */
#define LEVEL_TYPE_NONE @"noLevels"

/**
 * Specifies the level type for matching game.
 */
#define LEVEL_TYPE_MATCHING @"matching"

/**
 * Specifies the level type for Canvas2D game.
 */
#define LEVEL_TYPE_2DCANVAS @"canvas2D"

@class SLTLevelParser;
@class SLTBoard;

/// Protocol
@protocol SLTLevelDelegate <NSObject>

@required

/**
 * Provides the level parser for the given level type.
 * @param levelType The type of the level.
 * @return SLTLevelParser The level type corresponding level parser.
 */
-(SLTLevelParser*) getParser:(NSString*)levelType;

@end

/// <summary>
/// The SLTLevel class represents the game's level.
/// </summary>
@interface SLTLevel : NSObject <SLTLevelDelegate>

/// The variation identifier of the level.
@property (nonatomic, strong, readonly) NSString* variationId;

/// The global index of the level.
@property (nonatomic, assign, readonly) NSInteger index;

/// The properties of the level.
@property (nonatomic, strong, readonly) NSDictionary* properties;

/// The content URL of the level.
@property (nonatomic, strong, readonly) NSString* contentUrl;

/// The content ready state.
@property (nonatomic, assign, readonly) BOOL contentReady;

/// The current version of the level.
@property (nonatomic, strong, readonly) NSString* version;

/// The local index of the level in the pack.
@property (nonatomic, assign, readonly) NSInteger localIndex;

/// The index of the pack the level is in.
@property (nonatomic, assign, readonly) NSInteger packIndex;

/**
 * @brief Inits instance of @b SLTLevel class with the given id, index, localIndex, packIndex, dataUrl, properties and version
 *
 * @param theId The identifier of the level.
 * @param theVariationId The variation identifier of the level.
 * @param theLevelType The type of the level.
 * @param theIndex The global index of the level.
 * @param theLocalIndex The local index of the level in the pack.
 * @param thePackIndex The index of the pack the level is in.
 * @param theContentUrl The content URL of the level.
 * @param theProperties The properties of the level.
 * @param theVersion The current version of the level.
 * @return The instance of @b SLTLevel class.
 */
-(id) initWithLevelId:(NSString*)theId variationId:(NSString*)theVariationId levelType:(NSString*)theLevelType index:(NSInteger)theIndex localIndex:(NSInteger)theLocalIndex packIndex:(NSInteger)thePackIndex contentUrl:(NSString*)theContentUrl properties:(id)theProperties andVersion:(NSString*)theVersion;

/**
 * Gets the board by identifier.
 * @param boardId The board identifier.
 * @return SLTBoard The board with provided identifier.
 */
- (SLTBoard*)boardWithId:(NSString*)boardId;

/**
 * Updates the content of the level.
 * @param theRootNode The root dictionary correspoding to level JSON data.
 */
- (void)updateContent:(NSDictionary*)theRootNode;

/**
 * Regenerates contents of all boards.
 */
- (void)regenerateAllBoards;

/**
 * Regenerates content of the board by identifier.
 * @param boardId The board identifier.
 */
- (void)regenerateBoardWithId:(NSString*)boardId;


@end
