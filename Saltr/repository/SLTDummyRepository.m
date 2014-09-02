/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTDummyRepository.h"

@implementation SLTDummyRepository

-(NSDictionary *) objectFromStorage:(NSString *)fileName {
    return nil;
}

-(NSDictionary *) objectFromCache:(NSString *)fileName {
    return nil;
}

-(NSString *) objectVersion:(NSString *)fileName {
    return nil;
}

-(void) saveObject:(NSString *)fileName objectToSave:(NSDictionary *)object {
}

-(void) cacheObject:(NSString *)fileName version:(NSString *)version object:(NSDictionary *)object {

}

-(NSDictionary *) objectFromApplication:(NSString *)fileName {
    return nil;
}

@end
