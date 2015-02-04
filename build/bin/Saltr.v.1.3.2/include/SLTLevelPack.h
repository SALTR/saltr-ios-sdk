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

/// <summary>
/// The SLTLevelPack class represents the collection of levels.
/// </summary>
@interface SLTLevelPack : NSObject

/// The unique identifier of the level pack.
@property(nonatomic, strong, readonly) NSString* token;

/// The index of the level pack.
@property(nonatomic, assign, readonly) NSInteger index;

/// The levels of the pack.
@property(nonatomic, strong, readonly) NSMutableArray* levels;

/**
 * @brief Inits instance of @b SLTLevelPack class with the given token, index and levels.
 *
 * @param theToken The unique identifier of the level pack.
 * @param theIndex The index of the level pack.
 * @param theLevels The levels of the pack.
 * @return The instance of @b SLTLevelPack class.
 */
-(id)initWithToken:(NSString*)theToken index:(NSInteger)theIndex andLevels:(NSMutableArray*)theLevels;

@end
