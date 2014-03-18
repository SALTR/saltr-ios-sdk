/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTRepository.h"

@implementation SLTRepository

-(id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSBundle *)libraryBundle {
    static NSBundle* libraryBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString* libraryBundlePath = [mainBundlePath stringByAppendingPathComponent:@"Saltr.bundle"];
        libraryBundle = [NSBundle bundleWithPath:libraryBundlePath];
    });
    return libraryBundle;
}

+(NSDictionary *) objectFromStorage:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);
    NSString* filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    return [self getInternal:filePath];
}

+(NSDictionary *) objectFromCache:(NSString *)fileName {
    /// @todo The line below is just for passing compilation
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    return [self getInternal:filePath];
}

+(NSDictionary *) objectFromApplication:(NSString *)fileName {

    NSString* filePath = [[[SLTRepository libraryBundle] bundlePath] stringByAppendingPathComponent:fileName];
    return [self getInternal:filePath];
}

+(NSString *) objectVersion:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    filePath = [filePath stringByAppendingString:@"_VERSION"];

    NSDictionary* version =[self getInternal:filePath];
    if (version) {
        return [version objectForKey:@"_VERSION"];
    }
    return nil;
}

+(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(NSDictionary *)object {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    [self saveInternal:filePath objectToSave:object];
    filePath = [filePath stringByAppendingString:@"_VERSION"];
    [self saveInternal:filePath objectToSave:[NSDictionary dictionaryWithObjectsAndKeys:version, @"_VERSION", nil]];
}

+(void) saveObject:(NSString *)fileName objectToSave:(NSDictionary *)object {
    NSString* filePath = [[[SLTRepository libraryBundle] bundlePath] stringByAppendingPathComponent:fileName];
    [self saveInternal:filePath objectToSave:object];
}

#pragma mark private functions

/// @todo should be tested
+(NSDictionary *) getInternal:(NSString *)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return nil;
    }
    @try {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
            NSError* error = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"JSONObjectWithData error: %@", error);
                return nil;
            }
            return dictionary;
        }
    } @catch (NSError* error) {
        NSLog(@"[MobileStorageEngine] : error while getting object.\nError : %@", [[error userInfo] description]);
    }
    @finally {
        NSLog(@"Done");
    }
    return nil;
}

+(void) saveInternal:(NSString *) filePath objectToSave:(NSDictionary *)object {
    @try {
        NSError* error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if (![jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
            NSLog(@"ERROR!!!");
        }
        
    } @catch (NSError* error) {
        NSLog(@"[MobileStorageEngine] : error while saving object.\nError : %@", [[error userInfo] description]);
    }
    @finally {
        NSLog(@"Done");
    }
}

@end
