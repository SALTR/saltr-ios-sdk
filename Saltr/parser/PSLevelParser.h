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

@class PSLevelStructure;
@class PSLevelBoard;
@class SLTLevelSettings;

@interface PSLevelParser : NSObject

//TODO review the dataFetched property, whether it is really needed
@property (nonatomic, assign, readonly) BOOL dataFetched;

+(instancetype) sharedInstance;

//Compile time error messages to avoid multiple allocation of @b SLTSaltr instance
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));

//Compile time error messages to avoid multiple initialization of @b SLTSaltr instance
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

//Compile time error messages to avoid multiple allocation of @b SLTSaltr instance
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

//TODO The comments will be filled during implementation of functionality.

- (void)parseData:(id)data andFillLevelStructure:(PSLevelStructure*)level;

- (SLTLevelSettings*)parseLevelSettings:(NSDictionary*)data;

/**
 * @brief
 *
 * @param rawBoard -
 * @param levelBoard -
 * @return -
 *
 * TODO The chunk implementation specific part should be moved to PSChunk class.
 */
- (void)regenerateChunksWithRawBoard:(NSDictionary*)rawBoard forLevelBoard:(PSLevelBoard*)levelBoard;

@end
