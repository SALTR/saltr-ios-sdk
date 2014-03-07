/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSRepository.h"

@implementation PSRepository

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

-(NSDictionary *) objectFromStorage:(NSString *)fileName {
    NSString* filePath = [[[PSRepository libraryBundle] bundlePath] stringByAppendingPathComponent:fileName];
    return [self getInternal:filePath];
}

-(NSDictionary *) objectFromCache:(NSString *)fileName {
    /// @todo The line below is just for passing compilation
    NSString* filePath = fileName;
    return [self getInternal:filePath];
}

-(NSDictionary *) objectFromApplication:(NSString *)fileName {
    /// @todo The line below is just for passing compilation
    NSString* filePath = fileName;
    return [self getInternal:filePath];
}

-(NSString *) objectVersion:(NSString *)fileName {
    /// @todo The line below is just for passing compilation
    return [NSString new];
}

-(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(NSDictionary *)object {
    NSString* filePath = fileName;
    [self saveInternal:filePath objectToSave:object];
}

-(void) saveObject:(NSString *)fileName objectToSave:(NSDictionary *)object {
    NSString* filePath = [[[PSRepository libraryBundle] bundlePath] stringByAppendingPathComponent:fileName];
    [self saveInternal:filePath objectToSave:object];
}

#pragma mark private functions

/// @todo should be tested
-(NSDictionary *) getInternal:(NSString *)filePath {
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

-(void) saveInternal:(NSString *) filePath objectToSave:(NSDictionary *)object {
    @try {
        NSError* error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
    } @catch (NSError* error) {
        NSLog(@"[MobileStorageEngine] : error while saving object.\nError : %@", [[error userInfo] description]);
    }
    @finally {
        NSLog(@"Done");
    }
}

@end
