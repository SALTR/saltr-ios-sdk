/*
 * @file SLTLevelPack.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface SLTLevelPack : NSObject

@property(nonatomic, strong, readonly) NSString* token;

@property(nonatomic, assign, readonly) NSInteger index;

@property(nonatomic, strong, readonly) NSMutableArray* levels;

-(id)initWithToken:(NSString*)theToken index:(NSInteger)theIndex andLevels:(NSMutableArray*)theLevels;

@end
