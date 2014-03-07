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
#import "PSAsset.h"

@class PSCell;

@interface PSAssetInstance : PSAsset

@property (nonatomic, strong, readonly) NSString* state;

- (id)initWithState:(NSString*)state type:(NSString*)type andKeys:(NSDictionary*)theKeys;

@end
