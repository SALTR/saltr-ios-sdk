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

@interface PSBoardData : NSObject

@property (nonatomic, strong, readonly) NSDictionary* assetMap;
@property (nonatomic, strong, readonly) NSDictionary* keyset;
@property (nonatomic, strong, readonly) NSDictionary* stateMap;

@end
