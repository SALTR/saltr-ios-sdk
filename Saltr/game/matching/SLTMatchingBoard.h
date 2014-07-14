/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoard.h"

@class SLTCells;

@interface SLTMatchingBoard : SLTBoard

@property(nonatomic, strong, readonly) SLTCells* cells;

@property(nonatomic, assign, readonly) NSInteger rows;

@property(nonatomic, assign, readonly) NSInteger cols;

-(id) initWithCells:(SLTCells*)theCells layers:(NSMutableArray *)theLayers andProperties:(NSDictionary *)theProperties;

@end
