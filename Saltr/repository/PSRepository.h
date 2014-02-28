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

@class PSSaltr;

/**
 * @brief This class is used for getting/setting object from/into storage.
 * Storage can be either file or cache or application.
 */
@interface PSRepository : NSObject

/**
 * @brief Gets the object from the file system
 * @param filename - the name of file to be obtained
 * @return - the obtained file
 */
-(PSSaltr *) objectFromStorage:(NSString *)fileName;

/**
 * @brief Gets the object from the cache
 * @param filename - the name of file to be obtained
 * @return - the obtained file
 */
-(PSSaltr *) objectFromCache:(NSString *)fileName;

/**
 * @brief Gets the object from the application
 * @param filename - the name of file to be obtained
 * @return - the obtained file
 */
-(PSSaltr *) objectFromApplication:(NSString *)fileName;

/**
 * @brief Gets the version of object
 * @param filename - the filename of obtaining object
 * @return - object version
 */
-(NSString *) objectVersion:(NSString *)fileName;

/**
 * @brief Caches the given object 
 * @param filename - the name of caching object
 * @param version - the version of caching object
 * @param object - the object to be cached
 */
-(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(PSSaltr *)Object;

/**
 * @brief Saves the given object into the file system
 * @param filename - the name of caching object
 * @param object - the object to be cached
 */
-(void) saveObject:(NSString *)fileName objectToSave:(PSSaltr *)Object;


@end
