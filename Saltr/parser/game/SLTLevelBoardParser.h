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

@class SLTLevelBoard;
@class SLTLevelSettings;

/**
 * @brief This is the interface of @b SLTLevelBoardParser class.
 *
 * Through the only instance of @b SLTLevelBoardParser class, the objects hierarchy of level boards are being created/initialized
 * correspoding to the given root node of JSON data.
 */

@interface SLTLevelBoardParser : NSObject

/// Returns the only instance of @b SLTLevelBoardParser class
+(instancetype) sharedInstance;

/// Compile time error messages to avoid multiple allocation of @b SLTSaltr instance
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));

/// Compile time error messages to avoid multiple initialization of @b SLTSaltr instance
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

/// Compile time error messages to avoid multiple allocation of @b SLTSaltr instance
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

/** 
 * @brief Parses level settings node of JSON data by extracting needed information to create and initialize instance of @b SLTLevelSettings
 *
 * @param rootNode - The root dictionary correspoding to level JSON data
 *
 * @return - The instance of @b SLTLevelSettings class initialized with data from JSON
 */
- (SLTLevelSettings*)parseLevelSettings:(NSDictionary*)rootNode;

/**
 * @brief Parses single board node of JSON by extracting the needed information to create and initialize instance of @b SLTLevelBoard
 *
 * @param boardNode - the node of JSON corresponding to the board
 * @param levelSettings - the object of @b SLTLevelSettings class
 *
 * @return - The instance of @b SLTLevelBoard class initialized with board node data
 */
- (SLTLevelBoard*)parseLevelBoard:(NSDictionary*)boardNode withLevelSettings:(SLTLevelSettings*)levelSettings;

/**
 * @brief Parses all board nodes of JSON by extracting the needed information to create and initialize the instances of @b SLTLevelBoard
 *
 * @param boardNodes - the "boards" node of JSON which includes all board nodes
 * @param levelSettings - the object of @b SLTLevelSettings class
 *
 * @return - The dictionary with board
 */
- (NSMutableDictionary*)parseLevelBoards:(NSDictionary*)boardNodes withLevelSettings:(SLTLevelSettings*)levelSettings;

@end
