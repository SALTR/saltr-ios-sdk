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

@class SLTSaltr;

/**
 * @brief This class is used for getting/setting object from/into storage.
 * Storage can be either file or cache or application.
 */
@interface SLTRepository : NSObject

/**
 * @brief Returns the path of resource bundle that library uses
 * @return - the bundle path, where the json data files are stored
 */
+ (NSBundle *)libraryBundle;

/// @todo unused
/**
 * @brief Gets the object from the file system
 * @param fileName - the name of file to be obtained
 * @return - the obtained file
 */
+(NSDictionary *) objectFromStorage:(NSString *)fileName;

/**
 * @brief Gets the object from the cache
 * @param fileName - the name of file to be obtained
 * @return - the obtained file
 */
+(NSDictionary *) objectFromCache:(NSString *)fileName;

/**
 * @brief Gets the object from the application
 * @param fileName - the name of file to be obtained
 * @return - the obtained file
 */
+(NSDictionary *) objectFromApplication:(NSString *)fileName;

/**
 * @brief Gets the version of object
 * @param fileName - the filename of obtaining object
 * @return - object version
 */
+(NSString *) objectVersion:(NSString *)fileName;

/**
 * @brief Caches the given object 
 * @param fileName - the name of caching object
 * @param version - the version of caching object
 * @param object - the object to be cached
 */
+(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(NSDictionary *)object;

/// @todo unused
/**
 * @brief Saves the given object into the file system
 * @param fileName - the name of caching object
 * @param object - the object to be cached
 */
//+(void) saveObject:(NSString *)fileName objectToSave:(NSDictionary *)object;

@end
