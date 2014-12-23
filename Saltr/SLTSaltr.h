/*
 * @file SLTSaltr.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

#import "SLTMobileRepository.h"

@class UIViewController;

@class SLTLevel;
@class SLTLevelPack;
@class SLTStatus;

extern const NSString* CLIENT;
extern const NSString* API_VERSION;

@protocol SaltrRequestDelegate <NSObject>

@required

/// Informs that getting App data request has succeeded
-(void) didFinishGettingAppDataRequest;

/// Informs that getting app data request has failed
-(void) didFailGettingAppDataRequest:(SLTStatus*)status;

/// Informs that getting level data body with level pack request has succeeded
-(void) didFinishGettingLevelDataRequest;

/// Informs that getting level data body with level pack request has failed
-(void) didFailGettingLevelDataRequest:(SLTStatus*)status;

@end

@interface SLTSaltr : NSObject {
    /// The delegate of @b SaltrRequestDelegate protocol
    __unsafe_unretained id <SaltrRequestDelegate> saltrRequestDelegate;
}

@property (nonatomic, strong, readwrite) NSObject<SLTRepositoryProtocolDelegate>* repository;

@property (nonatomic, assign, readwrite) BOOL useNoLevels;

@property (nonatomic, assign, readwrite) BOOL useNoFeatures;

@property (nonatomic, assign, readwrite) bool devMode;

@property (nonatomic, assign, readwrite) BOOL autoRegisterDevice;

@property (nonatomic, assign, readwrite) NSInteger requestIdleTimeout;

@property (nonatomic, strong, readonly) NSArray* levelPacks;

@property (nonatomic, strong, readonly) NSArray* allLevels;

@property (nonatomic, assign, readonly) NSUInteger allLevelsCount;

@property (nonatomic, strong, readonly) NSArray* experiments;

@property (nonatomic, strong, readwrite) NSString* socialId;

/// The delegate of @b SaltrRequestDelegate protocol
@property (nonatomic, assign) id <SaltrRequestDelegate> saltrRequestDelegate;

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

- (void) start;

- (void) connect;

- (void) registerDevice;

- (void) connectWithBasicProperties:(NSDictionary*)theBasicProperties;

- (void) connectWithBasicProperties:(NSDictionary *)theBasicProperties andCustomProperties:(NSDictionary*)theCustomProperties;

-(void) loadLevelContent:(SLTLevel*)level andCacheEnabled:(BOOL)enableCache;

-(void) addProperties:(NSDictionary*)basicProperties andCustomProperties:(NSDictionary*)theCustomProperties;

@end
