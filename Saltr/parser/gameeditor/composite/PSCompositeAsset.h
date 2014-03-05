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
#import "PSBoardAsset.h"

@class PSCell;

@interface PSCompositeAsset : PSBoardAsset

@property (nonatomic, strong, readonly) NSArray* shifts;
@property (nonatomic, strong, readonly) PSCell* basis;

- (id)initWithShifts:(NSArray*)shifts basis:(PSCell*)basis type:(NSString*)theType andKeys:(NSDictionary*)theKeys;

@end
