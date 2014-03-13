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

/**
 * The public interface of game level pack.
 *
 * An instance of @b SLTLevelPack has collection of @b SLTLevel instances.
 */
@interface SLTLevelPack : NSObject

/// The token of @b SLTLevelPack instance
@property (nonatomic, strong, readonly) NSString* token;

/// The collection of @b SLTLevel instances
@property (nonatomic, strong, readonly) NSArray* levels;

/// The index of @b SLTLevelPack instance
@property (nonatomic, strong, readonly) NSString* index;

/**
 * @brief Inits instance of @b SLTLevelPack class with the given token, level list and index
 *
 * @param theToken - the token of @b SLTLevelPack instance
 * @param theLevels - the collection of @b SLTLevel instances
 * @param theIndex - the index of @b SLTLevelPack instance
 * @return - The instance of @b SLTLevelPack class
 */
-(id) initWithToken:(NSString*)theToken levels:(NSArray*)theLevels andIndex:(NSString*)theIndex;

@end
