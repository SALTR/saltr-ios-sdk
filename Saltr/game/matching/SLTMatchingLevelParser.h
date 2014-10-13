/*
 * @file SLTMatchingLevelParser.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTLevelParser.h"

@interface SLTMatchingLevelParser : SLTLevelParser

/// Returns the only instance of SLT2DLevelParser class
+ (instancetype)sharedInstance;

/// Compile time error messages to avoid multiple allocation of @b SLT2DLevelParser instance
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));

/// Compile time error messages to avoid multiple initialization of @b SLT2DLevelParser instance
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

/// Compile time error messages to avoid multiple allocation of @b SLT2DLevelParser instance
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

@end
