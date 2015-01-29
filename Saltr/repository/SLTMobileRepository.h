/*
 * @file SLTMobileRepository.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/// Protocol
@protocol SLTRepositoryProtocolDelegate <NSObject>

@required

/**
 * @brief Provides an object from storage.
 * @param fileName The name of the object.
 * @return The requested object.
 */
-(NSDictionary *) objectFromStorage:(NSString *)fileName;

/**
 * @brief Provides an object from cache.
 * @param fileName The name of the object.
 * @return The requested object.
 */
-(NSDictionary *) objectFromCache:(NSString *)fileName;

/**
 * @brief Provides the object's version.
 * @param fileName The name of the object.
 * @return The version of the requested object.
 */
-(NSString *) objectVersion:(NSString *)fileName;

/**
 * @brief Stores an object.
 * @param fileName The name of the object.
 * @param object The object to store.
 */
-(void) saveObject:(NSString *)fileName objectToSave:(NSDictionary *)object;

/**
 * @brief Caches an object.
 * @param fileName The name of the object.
 * @param version The version of the object.
 * @param object The object to store.
 */
-(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(NSDictionary *)object;

/**
 * @brief Provides an object from application.
 * @param fileName The name of the object.
 * @return The requested object.
 */
-(NSDictionary *) objectFromApplication:(NSString *)fileName;

@end

/// <summary>
/// The SLTMobileRepository class represents the mobile repository.
/// </summary>
@interface SLTMobileRepository : NSObject  <SLTRepositoryProtocolDelegate>

@end
