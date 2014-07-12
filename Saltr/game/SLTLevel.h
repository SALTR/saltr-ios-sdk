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

#define LEVEL_TYPE_NONE @"noLevels"
#define LEVEL_TYPE_MATCHING @"matching"
#define LEVEL_TYPE_2DCANVAS @"2DCanvas"

@class SLTLevelParser;

/// Protocol
@protocol SLTLevelDelegate <NSObject>

@required

-(SLTLevelParser*) getParser;

@end

/**
 * The public interface of game @b SLTLevel class.
 */
@interface SLTLevel : NSObject <SLTLevelDelegate>

/// The global index of level
@property (nonatomic, assign, readonly) int index;

/// The properties of level
@property (nonatomic, strong, readonly) NSDictionary* properties;

/// The url of level json content on the server
@property (nonatomic, strong, readonly) NSString* contentUrl;

/// This property shows where the data is parsed and corresponding objects hierarchy is created/initialized with the JSON content
@property (nonatomic, assign, readonly) BOOL contentReady;

/// The version of level
@property (nonatomic, strong, readonly) NSString* version;

/// The local index of level
@property (nonatomic, assign, readonly) int localIndex;

/// The index of level pack
@property (nonatomic, assign, readonly) int packIndex;

/**
 * @brief Inits instance of @b SLTLevel class with the given id, index, localIndex, packIndex, dataUrl, properties and version
 *
 * @param theId - id of level
 * @param theIndex - global index of level
 * @param theLocalIndex - local index of level
 * @param thePackIndex - index of level pack
 * @param theContentDataUrl - url of level json data on the server
 * @param theProperties - properties of level get from JSON
 * @param theVersion - the version of level
 * @return - The instance of @b SLTLevel class
 */
-(id) initWithLevelId:(NSString*)theId index:(int)theIndex localIndex:(int)theLocalIndex packIndex:(int)thePackIndex contentUrl:(NSString*)theContentUrl properties:(id)theProperties andVersion:(NSString*)theVersion;

/**
 * @brief Returns the @b SLTLevelBoard object from the available boards
 *
 * @param boardId - The ID of board, which object user needs to get
 * @return - The @b SLTLevelBoard object that corresponds to boardId
 */
//- (SLTLevelBoard*)boardWithId:(NSString*)boardId;

/**
 * @brief Parses the given data and generates the corresponding object hierarchy filling the parsed information there.
 *
 * @param theRootNode - The root dictionary correspoding to level JSON data
 */
- (void)updateContent:(NSDictionary*)theRootNode;

/**
 * @brief Generates all boards for the @b SLTLevel
 */
- (void)regenerateAllBoards;

/**
 * @brief Generates the boards of @b SLTLevel with the given boardId.
 *
 * @param boardId - The ID of board
 */
- (void)regenerateBoardWithId:(NSString*)boardId;


@end
