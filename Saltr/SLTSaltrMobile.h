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

#import "SLTMobileRepository.h"

@class SLTLevel;
@class SLTLevelPack;

@interface SLTSaltrMobile : NSObject

@property (nonatomic, strong, readwrite) NSObject<SLTRepositoryProtocolDelegate>* repository;

@property (nonatomic, assign, readwrite) BOOL useNoLevels;

@property (nonatomic, assign, readwrite) BOOL useNoFeatures;

@property (nonatomic, assign, readwrite) BOOL devMode;

@property (nonatomic, assign, readwrite) NSInteger requestIdleTimeout;

@property (nonatomic, strong, readonly) NSArray* levelPacks;

@property (nonatomic, strong, readonly) NSArray* allLevels;

@property (nonatomic, assign, readonly) NSUInteger allLevelsCount;

@property (nonatomic, strong, readonly) NSArray* experiments;

@property (nonatomic, strong, readwrite) NSString* socialId;

- (id) initSaltrWithClientKey:(NSString*)theClientKey deviceId:(NSString*)theDeviceId andCacheEnabled:(BOOL)theCacheEnabled;

- (SLTLevel*) getLevelByGlobalIndex:(NSUInteger)theIndex;

- (SLTLevelPack*) getPackByLevelGlobalIndex:(NSUInteger)theIndex;

- (NSArray*) getActiveFeatureTokens;

- (NSDictionary*) getFeaturePropertiesByToken:(NSString*)theToken;

- (void) importLevelsFromPath:(NSString*)thePath;

/**
 * If you want to have a feature synced with SALTR you should call define before getAppData call.
 */
- (void) defineFeatureWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties andRequired:(BOOL)theRequired;

@end
