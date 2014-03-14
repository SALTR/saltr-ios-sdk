/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTSaltr.h"
#import "SLTFeature.h"
#import "SLTResource.h"
#import "SLTDeserializer.h"
#import "SLTExperiment.h"
#import "PSLevelPackStructure.h"
#import "SLTPartner.h"
#import "SLTDevice.h"
#import "PSLevelParser.h"
#import "Constants.h"
#import "Helper.h"

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

/**
 * @def LEVEL_PACK_URL_PACKAGE
 * The url of level pack package
 */
#define LEVEL_PACK_URL_PACKAGE @"saltr/level_packs.json"


#define RESULT_SUCCEED @"SUCCEED"
#define RESULT_ERROR @"ERROR"


@interface SLTSaltr() {
    SLTRepository* _repository;
    NSString* _saltrUserId;
    /// @todo the meaning of this boolean is not clear yet
    BOOL _isLoading;
    BOOL _connected;
    SLTPartner* _partner;
    SLTDeserializer* _deserializer;

    SLTDevice* _device;
}

@end

@implementation SLTSaltr

@synthesize instanceKey = _instanceKey;
@synthesize enableCache;
@synthesize appVersion;
@synthesize ready;
@synthesize features=_features;
@synthesize levelPackStructures=_levelPackStructures;
@synthesize experiments=_experiments;
@synthesize saltrRequestDelegate;
@synthesize connected=_connected;

-(id) initUniqueInstance
{
    self = [super init];
    if (self) {
        _repository = [SLTRepository new];
        _deserializer = [SLTDeserializer new];
        _features = [NSMutableDictionary new];
        _isLoading = false;
        _connected = false;
    }
    return self;
}

-(void) setInstanceKey:(NSString *)instanceKey
{
    _instanceKey = instanceKey;
}

+(id) saltrWithInstanceKey:(NSString *)instanceKey andCacheEnabled:(BOOL)enableCache
{
    [SLTSaltr sharedInstance].instanceKey = instanceKey;
    [SLTSaltr sharedInstance].enableCache = enableCache;
    return [SLTSaltr sharedInstance];
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

-(SLTFeature *) feature :(NSString *)token {
    return [_features objectForKey:token];
}

-(void) setupPartnerWithId:(NSString *)partnerId andPartnerType:(NSString *)partnerType {
    _partner = [[SLTPartner alloc] initWithPartnerId:partnerId andPartnerType:partnerType];
}

-(void) setupDeviceWithId:(NSString *)deviceId andDeviceType:(NSString *)deviceType {
    _device = [[SLTDevice alloc] initWithDeviceId:deviceId andDeviceType:deviceType];
}

-(void) importLevels:(NSString *)path {
    path = !path ? LEVEL_PACK_URL_PACKAGE : path;
    NSDictionary* applicationData = [_repository objectFromApplication:path];
    _levelPackStructures = [_deserializer decodeLevelsFromData:applicationData];
}

-(void) defineFeatureWithToken:(NSString*)token andProperties:(NSDictionary *)properties {
    SLTFeature* feature = [_features objectForKey:token];
    if (nil == feature) {
        feature = [[SLTFeature alloc] initWithToken:token defaultProperties:properties andProperties:nil];
        [_features setValue:feature forKey:token];
    } else {
        feature.defaultProperties = properties;
    }
}

-(void) start {
    if (_isLoading) {
        return;
    }
    [self applyCachedFeatures];
    _isLoading = YES;
    _connected = NO;
    void (^appDataLoadFailedCallback)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        [self loadAppDataFailHandler];
    };
    void (^appDataLoadCompleteCallback)(SLTResource*) = ^(SLTResource* asset) {
        NSDictionary* data = asset.jsonData;
        NSDictionary* jsonData = [data objectForKey:@"responseData"];
        
        [_repository cacheObject:APP_DATA_URL_CACHE version:@"0" object:jsonData];
        [asset dispose];
        _isLoading = NO;
        _connected = YES;
        [self loadAppDataSuccessHandler:jsonData];
    };
    SLTResource* asset = [self createDataResource:appDataLoadCompleteCallback errorHandler:appDataLoadFailedCallback];
    [asset load];
}

-(void) loadLevelContentData:(PSLevelPackStructure*)levelPackStructure
                    levelStructure:(PSLevelStructure*)levelStructure andCacheEnabled:(BOOL)cacheEnabled {
    if (!cacheEnabled) {
        [self loadLevelContentDataFromSaltr:levelPackStructure levelData:levelStructure forceNoCache:YES];
        return;
    }
    
    //if there are no version change than load from cache
    NSString* cachedFileName = [Helper formatString:LEVEL_DATA_URL_CACHE_TEMPLATE andString2:levelPackStructure.index andString3:levelStructure.index];
                                
    
    if (levelStructure.version == [_repository objectVersion:cachedFileName]) {
        [self loadLevelDataCached:levelStructure cachedFileName:cachedFileName];
    } else {
        [self loadLevelContentDataFromSaltr:levelPackStructure levelData:levelStructure forceNoCache:NO];
    }
}

-(void) addUserPropertyWithNames:(NSArray *)propertyNames
                          values:(NSArray *)propertyValues
                   andOperations:(NSArray *)operations {
    
    NSMutableDictionary* args = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_saltrUserId, @"saltId", nil];
    NSMutableArray* properties = [NSMutableArray new];
    for (NSInteger i = 0; i < [propertyNames count]; ++i) {
        NSString* propertyName = [propertyNames objectAtIndex:i];
        NSString* propertyValue = [propertyValues objectAtIndex:i];
        NSString* operation = [operations objectAtIndex:i];
        [properties addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:propertyValue, operation, nil], propertyName, nil]];
    }
    [args setObject:properties forKey:@"properties"];
    [args setObject:_instanceKey forKey:@"instanceKey"];
    
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!error) {
        NSString *jsonArguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        jsonArguments = [jsonArguments stringByRemovingPercentEncoding];
        NSString* urlVars = [NSString stringWithFormat:@"?command=%@&arguments=%@", COMMAND_ADD_PROPERTY, jsonArguments];
        
        
        SLTResourceURLTicket* ticket = [[SLTResourceURLTicket alloc] initWithURL:SALTR_API_URL andVariables:urlVars];
        /// @todo the code below should be reviewed/rewritten
        SLTResource* resource = nil;
        void (^addUserPropertySuccessHandler)() = ^() {
            [resource dispose];
        };
        void (^addUserPropertyFailHandler)() = ^() {
            [resource dispose];
        };
        resource = [[SLTResource alloc] initWithId:@"property" andTicket:ticket successHandler:addUserPropertySuccessHandler errorHandler:addUserPropertyFailHandler progressHandler:nil];
        [resource load];
    }
}

#pragma mark private functions

-(void) applyCachedFeatures {
    NSDictionary* cachedData = [_repository objectFromCache:APP_DATA_URL_CACHE];
    NSDictionary* cachedFeatures = [_deserializer decodeFeaturesFromData:cachedData];
    for (NSString* token in [cachedFeatures allKeys]) {
        SLTFeature* saltrFeature = [cachedFeatures objectForKey:token];
        SLTFeature* defaultFeature = [_features objectForKey:token];
        if (defaultFeature) {
            saltrFeature.defaultProperties = defaultFeature.defaultProperties;
        }
        [_features setObject:saltrFeature forKey:token];
    }
}

-(SLTResource *)createDataResource:(void (^)(SLTResource *))appDataAssetLoadCompleteHandler errorHandler:(void (^)(SLTResource *))appDataAssetLoadErrorHandler {
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:_instanceKey forKey:@"instanceKey"];
    if (_device) {
        [args setObject:[_device toDictionary] forKey:@"device"];
    }
    if (_partner) {
        [args setObject:[_partner toDictionary] forKey:@"partner"];
    }
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!error) {
        NSString *jsonArguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonArguments = [jsonArguments stringByRemovingPercentEncoding];
        NSString* urlVars = [NSString stringWithFormat:@"?command=%@&arguments=%@", COMMAND_APP_DATA, jsonArguments];
        
        SLTResourceURLTicket* ticket = [[SLTResourceURLTicket alloc] initWithURL:SALTR_API_URL andVariables:urlVars];
        SLTResource* resource = [[SLTResource alloc] initWithId:@"saltAppConfig" andTicket:ticket successHandler:appDataAssetLoadCompleteHandler errorHandler:appDataAssetLoadErrorHandler progressHandler:nil];
        return resource;
    }
    return nil;
}

-(void) loadAppDataSuccessHandler:(NSDictionary *)jsonData {
     _saltrUserId = [jsonData objectForKey:@"saltId"];
    _features = [NSMutableDictionary new];
    _experiments = [_deserializer decodeExperimentsFromData:jsonData];
    _levelPackStructures = [_deserializer decodeLevelsFromData:jsonData];
    NSDictionary* saltrFeatures = [_deserializer decodeFeaturesFromData:jsonData];
    //merging with defaults...

    for (NSString* key in [saltrFeatures allKeys]) {
        SLTFeature* saltrFeature = [saltrFeatures objectForKey:key];
        SLTFeature* defaultFeature = [_features objectForKey:key];
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
    _isLoading = NO;
    _connected = NO;
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingAppDataRequest)]) {
        [saltrRequestDelegate didFailGettingAppDataRequest];
    }
    NSLog(@"[SaltClient] ERROR: App data is not loaded.");
}

-(void) syncFeatures {
    NSString* urlVars = [NSString stringWithFormat:@"?command=%@&instanceKey=%@", COMMAND_SAVE_OR_UPDATE_FEATURE, _instanceKey];
    
    if (appVersion) {
        [urlVars stringByAppendingFormat:@",appVersion=%@", appVersion];
    }
    NSMutableArray* featureList = [NSMutableArray new];
    for (NSString* key in [_features allKeys]) {
        SLTFeature* feature = [_features objectForKey:key];
        if (feature.defaultProperties) {
            
            NSError* error = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:feature.defaultProperties
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:&error];
            if (!error) {
                NSString *jsonDefaultProperties = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                
                [featureList addObject:[NSDictionary dictionaryWithObjectsAndKeys:jsonDefaultProperties, feature.token, nil]];
            }
        }
    }
    if ([featureList count]) {
        NSError* error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:featureList
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (!error) {
            NSString *properties = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [urlVars stringByAppendingFormat:@",data=%@", properties];
        }        
        SLTResourceURLTicket* ticket = [[SLTResourceURLTicket alloc] initWithURL:SALTR_URL andVariables:urlVars];
        void (^syncSuccessCallback)() = ^() {
        };
        void (^syncFailCallback)() = ^() {
        };
        SLTResource* resource = [[SLTResource alloc] initWithId:@"saveOrUpdateFeature" andTicket:ticket successHandler:syncSuccessCallback errorHandler:syncFailCallback progressHandler:nil];
        [resource load];
    }
}



-(void)loadLevelContentDataFromSaltr:(PSLevelPackStructure *)levelPackData
                     levelData:(PSLevelStructure *)levelData forceNoCache:(BOOL)forceNoCache {
    
    NSInteger timeInterval = [NSDate timeIntervalSinceReferenceDate] * 1000;
    NSString* url = [levelData.dataUrl stringByAppendingFormat:@"_time_=%d", timeInterval];
    NSString* dataUrl = forceNoCache ? url : levelData.dataUrl;
    SLTResourceURLTicket* ticket = [[SLTResourceURLTicket alloc] initWithURL:dataUrl andVariables:nil];
    /// @todo the code below should be reviewed/rewritten
    SLTResource* asset = nil;
    
    void (^levelDataAssetLoadedHandler)() = ^() {
        NSDictionary* data = asset.jsonData;
        NSString* cachedFileName = [Helper formatString:LEVEL_DATA_URL_CACHE_TEMPLATE andString2:levelPackData.index andString3:levelData.index];
        if (!asset.jsonData) {
            [self loadLevelDataLocally:levelPackData levelData:levelData cachedFileName:cachedFileName];
        } else {
            [self levelLoadSuccessHandler:levelData data:data];
            [_repository cacheObject:cachedFileName version:levelData.version object:data];
        }
        [asset dispose];
    };
    void (^levelDataAssetLoadErrorHandler)() = ^() {
        NSString* cachedFileName = [Helper formatString:LEVEL_DATA_URL_CACHE_TEMPLATE andString2:levelPackData.index andString3:levelData.index];
        
        [self loadLevelDataLocally:levelPackData levelData:levelData cachedFileName:cachedFileName];
        [asset dispose];
    };
    asset = [[SLTResource alloc] initWithId:@"saltr" andTicket:ticket successHandler:levelDataAssetLoadedHandler errorHandler:levelDataAssetLoadErrorHandler progressHandler:nil];
    [asset load];
}

-(BOOL) loadLevelDataCached:(PSLevelStructure *)levelData
             cachedFileName:(NSString *) cachedFileName {
    NSLog(@"[SaltClient::loadLevelData] LOADING LEVEL DATA CACHE IMMEDIATELY.");
    NSDictionary* data = [_repository objectFromCache:cachedFileName];
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
    NSString* url = [Helper formatString:LEVEL_DATA_URL_LOCAL_TEMPLATE andString2:levelPackData.index andString3:levelData.index];
    NSDictionary* data = [_repository objectFromApplication:url];
    if (data) {
        [self levelLoadSuccessHandler:levelData data:data];
    } else {
        [self levelLoadErrorHandler];
    }
}

@end