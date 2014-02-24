//
//  PSLevelBoard.h
//  Saltr
//
//  Created by Instigate Mobile on 2/21/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

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
