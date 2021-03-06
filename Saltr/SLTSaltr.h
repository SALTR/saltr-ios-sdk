/*
 * @file SLTSaltr.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

/*! \mainpage notitle
 \section intro_sec INTRODUCTION
 
 SALTR iOS SDK is a library of classes which help to develop mobile games that are to be integrated with SALTR platform.
 SDK performs all necessary and possible action with SALTR REST API to connect, update, set and download data related to game's features or levels.
 All data received from SALTR REST API is parsed and represented through set of instances of classes, each carrying specific objects and their properties.
 Basically SDK, as the REST API, has few simple actions. The most important one is connecting (getAppData), which loads the app data objects containing features, experiments and level headers.
 This and other actions will be described in the sections below.
 \section intro_usage USAGE
 
 To use the SDK you need to download/clone SDK repository, and then import files to your project.
 To clone Git repository via command line:
 $ git clone https://github.com/plexonic/saltr-ios-sdk.git
 The entry point in SDK is SLTSaltr class.
 Note: All classes in the package start with "SLT" prefix.
 \section intro_directory DIRECTORY STRUCTURE
 
 The SDK has the following directory structure:<br />
 /src - root folder of the library;<br />
 saltr - main package of library;<br />
 saltr.game - package contains game related classes;<br />
 saltr.game.canvas2d - classes related to 2D games;<br />
 saltr.game.matching - classes related to matching or board based games;<br />
 saltr.game.repository - local data repository classes (implementation widely varies through platforms);<br />
 saltr.game.status - status classes representing warnings and error statuses used within library code;<br />
 saltr.game.utils - helper or utility classes;<br />
 New packages supporting new gameplays and genres will be be added to saltr.game package.
  */

#import <Foundation/Foundation.h>

#import "SLTMobileRepository.h"

@class UIViewController;

@class SLTLevel;
@class SLTLevelPack;
@class SLTStatus;

extern const NSString* CLIENT;
extern const NSString* API_VERSION;

/// Protocol
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

/// <summary>
/// The SLTSaltr class represents the entry point to SDK.
/// </summary>
@interface SLTSaltr : NSObject {
    /// The delegate of @b SaltrRequestDelegate protocol
    __unsafe_unretained id <SaltrRequestDelegate> saltrRequestDelegate;
}

/// The repository.
@property (nonatomic, strong, readwrite) NSObject<SLTRepositoryProtocolDelegate>* repository;

/// The levels using state.
@property (nonatomic, assign, readwrite) BOOL useNoLevels;

/// The feature using state.
@property (nonatomic, assign, readwrite) BOOL useNoFeatures;

/// The dev mode state.
@property (nonatomic, assign, readwrite) bool devMode;

/// The device autoregistration state.
@property (nonatomic, assign, readwrite) BOOL autoRegisterDevice;

/// The request idle timeout.
@property (nonatomic, assign, readwrite) NSInteger requestIdleTimeout;

/// The level packs.
@property (nonatomic, strong, readonly) NSArray* levelPacks;

/// All levels.
@property (nonatomic, strong, readonly) NSArray* allLevels;

/// The total levels number.
@property (nonatomic, assign, readonly) NSUInteger allLevelsCount;

/// THe experiments.
@property (nonatomic, strong, readonly) NSArray* experiments;

/// The social identifier.
@property (nonatomic, strong, readwrite) NSString* socialId;

/// The delegate of @b SaltrRequestDelegate protocol
@property (nonatomic, assign) id <SaltrRequestDelegate> saltrRequestDelegate;

/**
 * @brief Inits an instance of @b SLTSaltr class with the given client key, device id and cache enabled state.
 *
 * @param theClientKey The client key.
 * @param theDeviceId The device unique identifier.
 * @param theCacheEnabled The cache enabled state.
 * @return The instance of @b SLTSaltr class.
 */
- (id) initSaltrWithClientKey:(NSString*)theClientKey deviceId:(NSString*)theDeviceId andCacheEnabled:(BOOL)theCacheEnabled;

/**
 * Provides the level by provided global index.
 * @param theIndex The global index of the level.
 * @return SLTLevel The level corresponding to provided global index.
 */
- (SLTLevel*) getLevelByGlobalIndex:(NSUInteger)theIndex;

/**
 * Provides the level pack by provided global index.
 * @param theIndex The global index of the level pack.
 * @return SLTLevelPack The level pack corresponding to provided global index.
 */
- (SLTLevelPack*) getPackByLevelGlobalIndex:(NSUInteger)theIndex;

/// Provides active feature tokens.
- (NSArray*) getActiveFeatureTokens;

/**
 * Provides the feature properties by provided token.
 * @param theToken The unique identifier of the feature.
 * @return NSDictionary The feature's properties.
 */
- (NSDictionary*) getFeaturePropertiesByToken:(NSString*)theToken;

/**
 * Imports level from provided path.
 * @param thePath The path of the levels.
 */
- (void) importLevelsFromPath:(NSString*)thePath;

/**
 * Define's feature.
 * @param theToken The unique identifier of the feature.
 * @param theProperties The properteis of the feature.
 * @param theRequired The requeired state of the feature.
 */
- (void) defineFeatureWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties andRequired:(BOOL)theRequired;

/// Starts the instance.
- (void) start;

/// Establishes the connection to Saltr server.
- (void) connect;

/// Opens device registration dialog.
- (void) registerDevice;

/**
 * Establishes the connection to Saltr with the provided basic properties.
 * @param theBasicProperties The basic properties.
 */
- (void) connectWithBasicProperties:(NSDictionary*)theBasicProperties;

/**
 * Establishes the connection to Saltr with the provided basic and custom properties.
 * @param theBasicProperties The basic properties.
 * @param theCustomProperties The custom properties.
 */
- (void) connectWithBasicProperties:(NSDictionary *)theBasicProperties andCustomProperties:(NSDictionary*)theCustomProperties;

/**
 * Loads the level content.
 * @param level The level.
 * @param enableCache The cache enabled state.
 */
-(void) loadLevelContent:(SLTLevel*)level andCacheEnabled:(BOOL)enableCache;

/**
 * Adds properties.
 * @param basicProperties The basic properties.
 * @param theCustomProperties The custom properties.
 */
-(void) addProperties:(NSDictionary*)basicProperties andCustomProperties:(NSDictionary*)theCustomProperties;

@end
