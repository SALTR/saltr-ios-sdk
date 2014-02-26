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

@class PSVector2D;
@class PSBoardData;

@interface PSLevelParser : NSObject

//TODO The comments will be filled during implementation of functionality.

/**
 * @brief 
 *
 * @param outputBoard -
 * @param board -
 * @param boardData -
 * @return - 
 * 
 * TODO outputboard parameter should be reviewed, whether it is needed to be passed as a variable to chunk and composite classes.
 * This static function also needs to be reviewed, whethere Level parser needs such public API
 */
+ (void)parseBoard:(PSVector2D*)outputBoard withBoard:(id)board andBoardData:(PSBoardData*)boardData;

/**
 * @brief
 *
 * @param outputBoard -
 * @param board -
 * @param boardData -
 * @return -
 *
 * TODO The chunk implementation specific part should be moved to PSChunk class.
 */
+ (void)regenerateChunks:(PSVector2D*)outputBoard withBoard:(id)board andBoardData:(PSBoardData*)boardData;

/**
 * @brief
 *
 * @param board -
 * @param boardData -
 * @return -
 *
 */
+ (PSBoardData*)parseBoardData:(PSBoardData*)boardData withData:(id)data;

@end
