//
//  PSIRepository.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

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
-(id) objectFromStorage:(NSString *)fileName;

/**
 * @brief Gets the object from the cache
 * @param filename - the name of file to be obtained
 * @return - the obtained file
 */
-(id) objectFromCache:(NSString *)fileName;

/**
 * @brief Gets the object from the application
 * @param filename - the name of file to be obtained
 * @return - the obtained file
 */
-(id) objectFromApplication:(NSString *)fileName;

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
-(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(id)Object;

/**
 * @brief Saves the given object into the file system
 * @param filename - the name of caching object
 * @param object - the object to be cached
 */
-(void) saveObject:(NSString *)fileName objectToSave:(id)Object;


@end
