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
#import "SLTLevelPack.h"
#import "PSPartner.h"
#import "PSDevice.h"
#import "SLTLevelBoardParser.h"
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

-(void) start {
    if (_isLoading) {
        return;
    }
    _isLoading = true;
    _ready = false;
    void (^resourceLoadFailHandler)(PSResource*) = ^(PSResource* asset) {
        NSLog(@"[SaltAPI] App data is failed to load.");
        
        [self loadAppDataInternal];
        [asset dispose];
    };
    void (^resourceLoadSuccessHandler)(PSResource*) = ^(PSResource* asset) {
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
    PSResource* asset = [self createDataResource:resourceLoadSuccessHandler errorHandler:resourceLoadFailHandler];
    [asset load];
}

-(void) levelDataBodyWithLevelPack:(SLTLevelPack*)levelPackStructure
                    levelStructure:(SLTLevel*)levelStructure andCacheEnabled:(BOOL)cacheEnabled {
    if (!cacheEnabled) {
        [self loadLevelDataFromServer:levelPackStructure levelData:levelStructure forceNoCache:YES];
        return;
    }
    
    //if there are no version change than load from cache
    NSString* cachedFileName = [Helper formatString:LEVEL_DATA_URL_CACHE_TEMPLATE andString2:levelPackStructure.index andString3:levelStructure.index];
                                
    
    if (levelStructure.version == [repository objectVersion:cachedFileName]) {
        [self loadLevelDataCached:levelStructure cachedFileName:cachedFileName];
    } else {
        [self loadLevelDataFromServer:levelPackStructure levelData:levelStructure forceNoCache:NO];
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
        NSDictionary* urlVars = [[NSDictionary alloc] initWithObjectsAndKeys:COMMAND_ADD_PROPERTY, @"command", jsonArguments, @"arguments", nil];
        NSData *urlVarsData = [NSKeyedArchiver archivedDataWithRootObject:urlVars];
        PSResourceURLTicket* ticket = [[PSResourceURLTicket alloc] initWithURL:SALTR_API_URL andVariables:urlVarsData];
        /// @todo the code below should be reviewed/rewritten
        PSResource* resource = nil;
        void (^addUserPropertySuccessHandler)() = ^() {
            [resource dispose];
        };
        void (^addUserPropertyFailHandler)() = ^() {
            [resource dispose];
        };
        resource = [[PSResource alloc] initWithId:@"property" andTicket:ticket successHandler:addUserPropertySuccessHandler errorHandler:addUserPropertyFailHandler progressHandler:nil];
        [resource load];
    }
}

#pragma mark private functions

-(PSResource *)createDataResource:(void (^)(PSResource *))resourceLoadSuccessHandler errorHandler:(void (^)(PSResource *))resourceLoadFailHandler {
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
        
        PSResourceURLTicket* ticket = [[PSResourceURLTicket alloc] initWithURL:SALTR_API_URL andVariables:urlVars];
        PSResource* resource = [[PSResource alloc] initWithId:@"saltAppConfig" andTicket:ticket successHandler:resourceLoadSuccessHandler errorHandler:resourceLoadFailHandler progressHandler:nil];
        return resource;
    }
    return nil;
}

-(void) loadAppDataSuccessHandler:(NSDictionary *)jsonData {
    _isLoading = false;
    _ready = true;
     _saltrUserId = [jsonData objectForKey:@"saltId"];
    _features = [NSMutableDictionary new];
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
    NSLog(@"[SaltClient] ERROR: App data is not loaded.");
}

-(void) syncFeatures {
    NSMutableDictionary* urlVars = [[NSMutableDictionary alloc] initWithObjectsAndKeys:COMMAND_APP_DATA, @"command", _instanceKey, @"instanceKey", nil];
    if (appVersion) {
        [urlVars setObject:appVersion forKey:@"appVersion"];
    }
    NSMutableArray* featureList = [NSMutableArray new];
    for (NSString* key in [_features allKeys]) {
        PSFeature* feature = [_features objectForKey:key];
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
            
            [urlVars setObject:properties forKey:@"data"];
            
        }
        
        NSData *urlVarsData = [NSKeyedArchiver archivedDataWithRootObject:urlVars];
        PSResourceURLTicket* ticket = [[PSResourceURLTicket alloc] initWithURL:SALTR_URL andVariables:urlVarsData];
        void (^syncSuccessHandler)() = ^() {
        };
        void (^syncFailHandler)() = ^() {
        };
        PSResource* resource = [[PSResource alloc] initWithId:@"saveOrUpdateFeature" andTicket:ticket successHandler:syncSuccessHandler errorHandler:syncFailHandler progressHandler:nil];
        [resource load];
    }
}



-(void)loadLevelDataFromServer:(SLTLevelPack *)levelPackData
                     levelData:(SLTLevel *)levelData forceNoCache:(BOOL)forceNoCache {
    
    NSInteger timeInterval = [NSDate timeIntervalSinceReferenceDate] * 1000;
    NSString* url = [levelData.contentDataUrl stringByAppendingFormat:@"_time_=%d", timeInterval];
    NSString* dataUrl = forceNoCache ? url : levelData.contentDataUrl;
    PSResourceURLTicket* ticket = [[PSResourceURLTicket alloc] initWithURL:dataUrl andVariables:nil];
    /// @todo the code below should be reviewed/rewritten
    PSResource* asset = nil;
    
    void (^levelDataAssetLoadedHandler)() = ^() {
        NSDictionary* data = asset.jsonData;
        NSString* cachedFileName = [Helper formatString:LEVEL_DATA_URL_CACHE_TEMPLATE andString2:levelPackData.index andString3:levelData.index];
        if (!asset.jsonData) {
            [self loadLevelDataLocally:levelPackData levelData:levelData cachedFileName:cachedFileName];
        } else {
            [self levelLoadSuccessHandler:levelData data:data];
            [repository cacheObject:cachedFileName version:levelData.version object:data];
        }
        [asset dispose];
    };
    void (^levelDataAssetLoadErrorHandler)() = ^() {
        NSString* cachedFileName = [Helper formatString:LEVEL_DATA_URL_CACHE_TEMPLATE andString2:levelPackData.index andString3:levelData.index];
        
        [self loadLevelDataLocally:levelPackData levelData:levelData cachedFileName:cachedFileName];
        [asset dispose];
    };
    asset = [[PSResource alloc] initWithId:@"saltr" andTicket:ticket successHandler:levelDataAssetLoadedHandler errorHandler:levelDataAssetLoadErrorHandler progressHandler:nil];
    [asset load];
}

-(BOOL) loadLevelDataCached:(SLTLevel *)levelData
             cachedFileName:(NSString *) cachedFileName {
    NSLog(@"[SaltClient::loadLevelData] LOADING LEVEL DATA CACHE IMMEDIATELY.");
    NSDictionary* data = [repository objectFromCache:cachedFileName];
    if (data) {
        [self levelLoadSuccessHandler:levelData data:data];
        return YES;
    }
    return NO;

}

-(void) levelLoadSuccessHandler:(SLTLevel *)levelData data:(id)data {
    [levelData updateContent:data];
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

-(void)loadLevelDataLocally:(SLTLevelPack *)levelPackData
                  levelData:(SLTLevel *)levelData cachedFileName:(NSString *)cachedFileName {
    if ([self loadLevelDataCached:levelData cachedFileName:cachedFileName]) {
        return;
    }
    [self loadLevelDataLocally:levelPackData levelData:levelData cachedFileName:cachedFileName];
}

-(void) loadLevelDataInternal:(SLTLevelPack *)levelPackData levelData:(SLTLevel *)levelData {
    NSString* url = [Helper formatString:LEVEL_DATA_URL_LOCAL_TEMPLATE andString2:levelPackData.index andString3:levelData.index];
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
