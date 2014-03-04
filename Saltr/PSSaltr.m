/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSSaltr.h"
#import "PSFeature.h"
#import "PSResource.h"
#import "PSDeserializer.h"
#import "PSExperiment.h"
#import "PSLevelPackStructure.h"
#import "PSPartner.h"
#import "PSDevice.h"
#import "PSLevelParser.h"

/**
 * @def APP_DATA_URL_CACHE
 * The filename of json file in application data cache
 */
#define APP_DATA_URL_CACHE @"app_data_cache.json"

/**
 * @def APP_DATA_URL_INTERNAL
 * The filename of json file in application internal directory
 */
#define APP_DATA_URL_INTERNAL @"saltr/app_data.json"

/**
 * @def LEVEL_DATA_URL_LOCAL_TEMPLATE
 * The filename of level data json file in application local directory
 */
#define LEVEL_DATA_URL_LOCAL_TEMPLATE @"saltr/pack_{0}/level_{1}.json"

/**
 * @def LEVEL_DATA_URL_CACHE_TEMPLATE
 * The filename of level data json file in application cache directory
 */
#define LEVEL_DATA_URL_CACHE_TEMPLATE @"pack_{0}_level_{1}.json"

#define RESULT_SUCCEED @"SUCCEED"
#define RESULT_ERROR @"ERROR"


@interface PSSaltr() {
    BOOL _isLoading;
    /// @todo the meaning of this boolean is not clear yet
    BOOL _ready;
    NSString* _saltrUserId;
    PSDeserializer* _deserializer;
    NSArray* _experiments;
    NSArray* _levelPackStructures;
    NSDictionary* _features;
    PSDevice* _device;
    PSPartner* _partner;
}

@end

@implementation PSSaltr

@synthesize instanceKey = _instanceKey;
@synthesize enableCache;
@synthesize appVersion;
@synthesize ready;
@synthesize repository;
@synthesize features;
@synthesize levelPackStructures;
@synthesize experiments;
@synthesize saltrRequestDelegate;

-(id) initUniqueInstance
{
    self = [super init];
    if (self) {
        self.repository = [PSRepository new];
        _deserializer = [PSDeserializer new];
        
        _isLoading = false;
        _ready = false;
    }
    return self;
}

-(void) setInstanceKey:(NSString *)instanceKey
{
    _instanceKey = instanceKey;
}

+(id) saltrWithInstanceKey:(NSString *)instanceKey andCacheEnabled:(BOOL)enableCache
{
    [PSSaltr sharedInstance].instanceKey = instanceKey;
    [PSSaltr sharedInstance].enableCache = enableCache;
    return [PSSaltr sharedInstance];
}

+(instancetype) sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[super alloc] initUniqueInstance];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(PSFeature *) feature :(NSString *)token {
    return [_features objectForKey:token];
}

-(void) setupPartnerWithId:(NSString *)partnerId andPartnerType:(NSString *)partnerType {
    _partner = [[PSPartner alloc] initWithPartnerId:partnerId andPartnerType:partnerType];
}

-(void) setupDeviceWithId:(NSString *)deviceId andDeviceType:(NSString *)deviceType {
    _device = [[PSDevice alloc] initWithDeviceId:deviceId andDeviceType:deviceType];
}

-(void) defineFeatureWithToken:(NSString*)token andProperties:(NSDictionary *)properties {
    PSFeature* feature = [features objectForKey:token];
    if (nil == feature) {
        feature = [[PSFeature alloc] initWithToken:token defaultProperties:nil andProperties:properties];
        [features setValue:feature forKey:token];
    } else {
        feature.defaultProperties = properties;
    }
}

/// @todo the interface of PSResource class is not ready yet
-(void) appData {
    if (_isLoading) {
        return;
    }
    _isLoading = true;
    _ready = false;
    void (^appDataAssetLoadErrorHandler)(PSResource*) = ^(PSResource* asset) {
        NSLog(@"[SaltAPI] App data is failed to load.");
        
        [self loadAppDataInternal];
        [asset dispose];
    };
    void (^appDataAssetLoadCompleteHandler)(PSResource*) = ^(PSResource* asset) {
        NSLog(@"[SaltAPI] App data is loaded.");
        NSDictionary* data = asset.jsonData;
        NSDictionary* jsonData = [data objectForKey:@"responseData"];
        NSLog(@"[SaltClient] Loaded App data. json = %@", jsonData);
        if (!jsonData || ![[data objectForKey:@"status"] isEqualToString:RESULT_SUCCEED]) {
            [self loadAppDataInternal];
        } else {
            [self loadAppDataSuccessHandler:jsonData];
            [repository cacheObject:APP_DATA_URL_CACHE version:@"0" object:jsonData];
        }
        [asset dispose];
    };
    PSResource* asset = [self createAppDataResource:appDataAssetLoadCompleteHandler errorHandler:appDataAssetLoadErrorHandler];
    [asset load];
}

-(void) levelDataBodyWithLevelPack:(PSLevelPackStructure*)levelPackStructure
                    levelStructure:(PSLevelStructure*)levelStructure andCacheEnabled:(BOOL)cacheEnabled {
    if (!cacheEnabled) {
        [self loadLevelDataFromServer:levelPackStructure levelData:levelStructure forceNoCache:YES];
        return;
    }
    
    //if there are no version change than load from cache
    NSString* cachedFileName = nil; //[Utils formatString(LEVEL_DATA_URL_CACHE_TEMPLATE, levelPackData.index, levelData.index)];

    if (levelStructure.version == [repository objectVersion:cachedFileName]) {
        [self loadLevelDataCached:levelStructure cachedFileName:cachedFileName];
    } else {
        [self loadLevelDataFromServer:levelPackStructure levelData:levelStructure forceNoCache:NO];
    }
}

-(void) addUserPropertyWithNames:(NSArray *)propertyNames
                          values:(NSArray *)propertyValues
                   andOperations:(NSArray *)operations {
    
}

#pragma mark private functions

/// @todo the implementation should be added
-(PSResource *)createAppDataResource:(void (^)(PSResource *))appDataAssetLoadCompleteHandler errorHandler:(void (^)(PSResource *))appDataAssetLoadErrorHandler {
    NSLog(@"[SaltAPI] App data is failed to load.");
    return [PSResource new];
}

-(void) loadAppDataSuccessHandler:(NSDictionary *)jsonData {
    _isLoading = false;
    _ready = true;
     _saltrUserId = [jsonData objectForKey:@"saltId"];
    
    _experiments = [_deserializer decodeExperimentsFromData:jsonData];
    _levelPackStructures = [_deserializer decodeLevelsFromData:jsonData];
    NSDictionary* saltrFeatures = [_deserializer decodeFeaturesFromData:jsonData];
    //merging with defaults...

    for (NSString* key in [saltrFeatures allKeys]) {
        PSFeature* saltrFeature = [saltrFeatures objectForKey:key];
        PSFeature* defaultFeature = [_features objectForKey:key];
        saltrFeature.defaultProperties = defaultFeature.defaultProperties;
        [_features setValue:saltrFeature forKey:key];
    }
    
    NSLog(@"[SaltClient] packs = %d", [_levelPackStructures count]);
    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingAppDataRequest)]) {
        [saltrRequestDelegate didFinishGettingAppDataRequest];
    }
    /// @todo the meaning of the boolean below is not clear.
    // The condition will be always true as the mentioned boolean never changes its value.
//    if (_isInDevMode) {
        [self syncFeatures];
//    }
}

-(void) loadAppDataFailHandler {
    _isLoading = false;
    _ready = false;
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingAppDataRequest)]) {
        [saltrRequestDelegate didFailGettingAppDataRequest];
    }
    NSLog(@"[SaltClient] ERROR: Level Packs are not loaded.");
}

/// @todo the implementation should be added
-(void) syncFeatures {
    
}

-(void)loadLevelDataFromServer:(PSLevelPackStructure *)levelPackData
                     levelData:(PSLevelStructure *)levelData forceNoCache:(BOOL)forceNoCache {
    
}

-(BOOL) loadLevelDataCached:(PSLevelStructure *)levelData
             cachedFileName:(NSString *) cachedFileName {
    NSLog(@"[SaltClient::loadLevelData] LOADING LEVEL DATA CACHE IMMEDIATELY.");
    NSDictionary* data = [repository objectFromCache:cachedFileName];
    if (data) {
        [self levelLoadSuccessHandler:levelData data:data];
        return YES;
    }
    return NO;

}

-(void) levelLoadSuccessHandler:(PSLevelStructure *)levelData data:(id)data {
    [[PSLevelParser sharedInstance] parseData:data andFillLevelStructure:levelData];
    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingLevelDataBodyWithLevelPackRequest)]) {
        [saltrRequestDelegate didFinishGettingLevelDataBodyWithLevelPackRequest];
    }
}

-(void)levelLoadErrorHandler {
    NSLog(@"[SaltClient] ERROR: Level data is not loaded.");
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingLevelDataBodyWithLevelPackRequest)]) {
        [saltrRequestDelegate didFailGettingLevelDataBodyWithLevelPackRequest];
    }
}

-(void)loadLevelDataLocally:(PSLevelPackStructure *)levelPackData
                  levelData:(PSLevelStructure *)levelData cachedFileName:(NSString *)cachedFileName {
    if ([self loadLevelDataCached:levelData cachedFileName:cachedFileName]) {
        return;
    }
    [self loadLevelDataLocally:levelPackData levelData:levelData cachedFileName:cachedFileName];
}

-(void) loadLevelDataInternal:(PSLevelPackStructure *)levelPackData levelData:(PSLevelStructure *)levelData {
    NSString* url = nil;//formatString(LEVEL_DATA_URL_LOCAL_TEMPLATE, levelPackData.index, levelData.index);
    NSDictionary* data = [repository objectFromApplication:url];
    if (data) {
        [self levelLoadSuccessHandler:levelData data:data];
    } else {
        [self levelLoadErrorHandler];
    }
}

-(void) loadAppDataInternal {
    NSLog(@"[SaltClient] NO Internet available - so loading internal app data.");
    NSDictionary* data = [repository objectFromCache:APP_DATA_URL_CACHE];
    if (data) {
        NSLog(@"[SaltClient] Loading App data from Cache folder.");
        [self loadAppDataSuccessHandler:data];
    } else {
        NSLog(@"[SaltClient] Loading App data from application folder.");
        data = [repository objectFromApplication:APP_DATA_URL_INTERNAL];
        if (data) {
            [self loadAppDataSuccessHandler:data];
        } else {
            [self loadAppDataFailHandler];
        }
    }
}

@end
