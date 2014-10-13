/*
 * @file SLTCells.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class SLTCell;
@class SLTCellsIterator;

@interface SLTCells : NSObject

@property(nonatomic, assign, readonly) NSInteger width;

@property(nonatomic, assign, readonly) NSInteger height;

@property(nonatomic, strong, readonly) SLTCellsIterator* iterator;

@property(nonatomic, strong, readonly) NSMutableArray* rawData;

-(id) initWithWidth:(NSInteger)theWidth andHeight:(NSInteger)theHeight;

-(void) insertCell:(SLTCell*)theCell atCol:(NSInteger)theCol andRow:(NSInteger)theRow;

-(SLTCell*) retrieveCellAtCol:(NSInteger)theCol andRow:(NSInteger)theRow;

@end
