/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSLevelStructure.h"

@interface PSLevelStructure ()

@property (nonatomic, strong, readwrite) PSBoardData* boardData;
@property (nonatomic, strong, readwrite) NSDictionary* innerProperties;
@property (nonatomic, strong, readwrite) NSMutableDictionary* boards;

@end