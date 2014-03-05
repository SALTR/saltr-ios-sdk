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

@interface PSSimpleAsset : PSBoardAsset

@property (nonatomic, strong, readonly) NSString* state;
@property (nonatomic, strong, readonly) PSCell* cell;

- (id)initWithState:(NSString*)state cell:(PSCell*)cell type:(NSString*)type andKeys:(NSDictionary*)theKeys;
@end
