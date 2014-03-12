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
#import "SLTRepository.h"
#import "PSLevelPackStructure.h"
#import "PSLevelStructure.h"

@class SLTFeature;

/// @todo Comments will be revised as more info is available

/// Protocol which defines required methods for managing success and fail responses for the requests
@protocol SaltrRequestDelegate <NSObject>

@required

/// Informs that getting App data request has succeeded
-(void) didFinishGettingAppDataRequest;

/// Informs that getting app data request has failed
-(void) didFailGettingAppDataRequest;

/// Informs that getting level data body with level pack request has succeeded
-(void) didFinishGettingLevelDataBodyWithLevelPackRequest;

/// Informs that getting level data body with level pack request has failed
-(void) didFailGettingLevelDataBodyWithLevelPackRequest;

@end

/**
 * @brief This is public interface for @b PSSaltr ios SDK. To us the sdk user 
 * needs to include this header file, implement @b SatrRequestDelegate protocol
 * and initialize the properties listed below.
 */
@interface SLTSaltr : NSObject {
    /// The delegate of @b SaltrRequestDelegate protocol
    __unsafe_unretained id <SaltrRequestDelegate> saltrRequestDelegate;
}

/// The instance key - unique to each Saltr object
@property (nonatomic, strong, readonly) NSString* instanceKey;

/// YES if caching should be enabled, otherwise NO
@property (nonatomic, assign) BOOL enableCache;

/// The application version
@property (nonatomic, strong) NSString* appVersion;

/// @todo this may be member
@property (nonatomic, strong) SLTRepository* repository;

/// YES if loading is done, otherwise NO
@property (nonatomic, assign, readonly) BOOL ready;

/// the features of current @b Saltr object
@property (nonatomic, strong, readonly) NSDictionary* features;

/// the level package structures of current  @b Saltr object
@property (nonatomic, strong, readonly) NSArray* levelPackStructures;

/// the experiments of current  @b Saltr object
@property (nonatomic, strong, readonly) NSArray* experiments;

/// The delegate of @b SaltrRequestDelegate protocol
@property (nonatomic, assign) id <SaltrRequestDelegate> saltrRequestDelegate;

/// Returns the only instance of Saltr class
+ (instancetype)sharedInstance;

//Compile time error messages to avoid multiple allocation of @b SLTSaltr instance
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));

//Compile time error messages to avoid multiple initialization of @b SLTSaltr instance
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

//Compile time error messages to avoid multiple allocation of @b SLTSaltr instance
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

/**
 * @brief Initializes Saltr class with the given instanceKey and enableCache flag
 *
 * @param instanceKey - the initialization key to initialize the current @b Saltr object
 * @param enableCache - YES, if caching should be enabled, otherwise NO
 * @return - The only instance of Saltr class
 */
+(id) saltrWithInstanceKey:(NSString *)instanceKey andCacheEnabled:(BOOL)enableCache;

/**
 * @brief Setup partner with the given ID and type
 * 
 * @param partnerId - the id  of the partner to be set for current @b Saltr object
 * @param partnerType - the type of the partner
 */
-(void) setupPartnerWithId:(NSString *)partnerId andPartnerType:(NSString *)partnerType;

/**
 * @brief Setup device with the given ID and type
 *
 * @param deviceId - the id  of the device to be set for current @b Saltr object
 * @param deviceType - the type of the device
 */
-(void) setupDeviceWithId:(NSString *)deviceId andDeviceType:(NSString *)deviceType;

/**
 * @brief Defines feature for the token and sets the properties
 * 
 * @param token - the number of feature to be set
 * @param properties - the properties to be set
 *
 *
 * @pre If you want to have a feature synced with SALTR you should call define 
 * before appData call.
 */
-(void) defineFeatureWithToken:(NSString*)token andProperties:(NSDictionary *)properties;

/**
 * @brief Gets the application data
 */
-(void) start;

/**
 * @brief Gets the body of level data
 * @param levelPackStructure - 
 * @param levelStructure - 
 * @param enableCache - YES, if caching should be enabled, otherwise NO
 */
-(void) levelDataBodyWithLevelPack:(PSLevelPackStructure*)levelPackStructure
                    levelStructure:(PSLevelStructure*)levelStructure
                   andCacheEnabled:(BOOL)enableCache;

/**
 * @brief Adds user properties to the current @b Saltr object
 * @param propertyNames - the list of properties
 * @param propertyValues - the list of property values
 * @param operations - the list of operation on that properties
 */
-(void) addUserPropertyWithNames:(NSArray *)propertyNames
                          values:(NSArray *)propertyValues
                   andOperations:(NSArray *)operations;

/**
 * @brief Gets the feature corresponding to the given token
 * @param token - token for which feature should be obtained
 * @return - obtaining feature
 */
-(SLTFeature *) feature :(NSString *)token;


@end

