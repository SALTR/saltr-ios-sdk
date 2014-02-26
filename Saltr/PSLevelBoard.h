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
#import "PSBoardData.h"
#import "PSVector2D.h"
#import "PSBoardData.h"

@interface PSLevelBoard : NSObject

/**
 * @brief Initializes the current @b PSLevelBoard class with the given rowBoard
 * and board data.
 * 
 * @param rowBoard
 * @param boardData-
 * @return - initialized object of @b PSLevelBoard class
 */
-(id) initWithRowBoard:(PSLevelBoard *)rowBoard andBoardData:(PSBoardData *)boardData;

-(void) regenerateChunks;

-(NSDictionary *)composites;
-(NSDictionary *) chunks;
-(NSInteger) countOfRows;
-(NSInteger) countOfColumns;
-(NSArray *) blockedCells;
-(NSArray *) position;
-(NSArray *) properties;
-(PSVector2D *) boardVector;
-(PSBoardData *) boardData;

@end
