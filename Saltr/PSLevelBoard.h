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

@class PSBoardData;
@class PSVector2D;
@class PSLevelStructure;

@interface PSLevelBoard : NSObject

@property (nonatomic, strong, readonly) PSLevelStructure* level;
@property (nonatomic, assign, readonly) NSInteger rows;
@property (nonatomic, assign, readonly) NSInteger cols;
@property (nonatomic, strong, readonly) NSArray* blockedCells;
@property (nonatomic, strong, readonly) NSArray* position;
@property (nonatomic, strong, readonly) PSVector2D* boardVector;
@property (nonatomic, strong, readonly) NSDictionary* rawBoard;
@property (nonatomic, strong, readonly) PSBoardData* boardData;


/**
 * @brief Initializes the current @b PSLevelBoard class with the given rowBoard
 * and board data.
 * 
 * @param rowBoard -
 * @param boardData -
 * @param levelStructure -
 * @return - initialized object of @b PSLevelBoard class
 */
- (id)initWithRawBoard:(id)theRawBoard andLevelStructure:(PSLevelStructure*)theLevelStructure;

- (void) regenerateChunks;

- (NSDictionary *)composites;
- (NSDictionary *)chunks;
- (id)boardProperties;
- (id)cellProperties;
@end
