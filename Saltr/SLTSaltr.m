/*
 * @file SLTSaltr.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTSaltr.h"

#import "SLTDummyRepository.h"
#import "SLTLevelPack.h"
#import "SLTLevel.h"
#import "SLTFeature.h"
#import "SLTConfig.h"
#import "SLTDeserializer.h"
#import "SLTResource.h"
#import "SLTResourceURLTicket.h"
#import "SLTStatusAppDataLoadFail.h"
#import "SLTStatusAppDataConcurrentLoadRefused.h"
#import "SLTStatusFeaturesParseError.h"
#import "SLTStatusExperimentsParseError.h"
#import "SLTStatusLevelsParseError.h"
#import "SLTStatusLevelContentLoadFail.h"

#import "DialogController.h"
#import "DeviceRegistrationDialog.h"

#import <UIKit/UIViewController.h>

NSString* CLIENT=@"IOS-Mobile";
NSString* API_VERSION=@"1.0.0";

@interface SLTSaltr() {
    UIViewController* _uiViewController;
    NSString* _clientKey;
    NSString* _deviceId;
    BOOL _isLoading;
    BOOL _connected;
    BOOL _useNoLevels;
    BOOL _useNoFeatures;
    NSString* _levelType;
    bool _devMode;
    BOOL _autoSyncEnabled;
    BOOL _isDataSynced;
    BOOL _started;
    NSInteger _requestIdleTimeout;
    NSMutableDictionary* _activeFeatures;
    NSMutableDictionary* _developerFeatures;
    NSObject<SLTRepositoryProtocolDelegate>* _repository;
    SLTDeserializer* _deserializer;
    DialogController* _dialogController;
}
@end

@implementation SLTSaltr

@synthesize saltrRequestDelegate;
@synthesize repository  = _repository;
@synthesize useNoLevels  = _useNoLevels;
@synthesize useNoFeatures  = _useNoFeatures;
@synthesize devMode  = _devMode;
@synthesize autoSyncEnabled  = _autoSyncEnabled;
@synthesize requestIdleTimeout  = _requestIdleTimeout;
@synthesize levelPacks  = _levelPacks;
@synthesize experiments  = _experiments;
@synthesize socialId  = _socialId;

- (id) initSaltrWithUiViewController:(UIViewController*)uiViewController clientKey:(NSString*)theClientKey deviceId:(NSString*)theDeviceId andCacheEnabled:(BOOL)theCacheEnabled
{
    self = [super init];
    if (self) {
        _uiViewController = uiViewController;
        _clientKey = theClientKey;
        _deviceId = theDeviceId;
        _isLoading = NO;
        _connected = NO;
        _useNoLevels = NO;
        _useNoFeatures = NO;
        _levelType = nil;
        
        _devMode = false;
        _autoSyncEnabled = YES;
        _isDataSynced = NO;
        _started = NO;
        _requestIdleTimeout = 0;
        
        _activeFeatures = [[NSMutableDictionary alloc] init];
        _developerFeatures = [[NSMutableDictionary alloc] init];
        _repository = theCacheEnabled ? [[SLTMobileRepository alloc] init] : [[SLTDummyRepository alloc] init];
        _deserializer = [[SLTDeserializer alloc] init];
    }
    return self;
}

- (NSArray *)allLevels {
    NSMutableArray* levels = [[NSMutableArray alloc] init];
    for (SLTLevelPack* levelPack in _levelPacks) {
        for (SLTLevel* level in [levelPack levels]) {
            [levels addObject:level];
        }
    }    
    return levels;
}

- (NSUInteger)allLevelsCount {
    NSUInteger count = 0;
    for (SLTLevelPack* levelPack in _levelPacks) {
        count += [[levelPack levels] count];
    }    
    return count;
}

- (SLTLevel*) getLevelByGlobalIndex:(NSUInteger)theIndex
{
    NSInteger levelsSum = 0;
    NSUInteger index = 0;
    for (SLTLevelPack* levelPack in _levelPacks) {
        NSInteger packLength = [[levelPack levels] count];
        if(theIndex >= levelsSum + packLength) {
            levelsSum += packLength;
        } else {
            NSInteger localIndex = theIndex - levelsSum;
            return [[[_levelPacks objectAtIndex:index] levels] objectAtIndex:localIndex];
        }
        ++index;
    }
    return nil;
}

- (SLTLevelPack*) getPackByLevelGlobalIndex:(NSUInteger)theIndex
{    
    NSInteger levelsSum = 0;
    NSUInteger index = 0;
    for (SLTLevelPack* levelPack in _levelPacks) {
        NSInteger packLength = [[levelPack levels] count];
        if(theIndex >= levelsSum + packLength) {
            levelsSum += packLength;
        } else {
            return [_levelPacks objectAtIndex:index];
        }
        ++index;
    }
    return nil;
}

- (NSArray*) getActiveFeatureTokens
{    
    NSMutableArray* tokens = [[NSMutableArray alloc] init];
    for(SLTFeature* feature in _activeFeatures) {
        [tokens addObject:[feature token]];
    }
    
    return tokens;
}

- (NSDictionary*) getFeaturePropertiesByToken:(NSString*)theToken
{    
    SLTFeature* activeFeature = [_activeFeatures objectForKey:theToken];
    if(activeFeature != nil) {
        return [activeFeature properties];
    } else {
        SLTFeature* devFeature = [_developerFeatures objectForKey:theToken];
        if(devFeature != nil && [devFeature required]) {
            return [devFeature properties];
        }
    }
    return nil;
}

- (void) importLevelsFromPath:(NSString*)thePath
{    
    if (_useNoLevels) {
        return;
    }
    
    if (NO == _started) {
        thePath = thePath == nil ? LOCAL_LEVELPACK_PACKAGE_URL : thePath;
        NSDictionary* applicationData = [_repository objectFromApplication:thePath];
        _levelPacks = [_deserializer decodeLevelsFromData:applicationData];
    } else {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Method 'importLevels()' should be called before 'start()' only."
                                  userInfo:nil];
        @throw exception;
    }
}

- (void) defineFeatureWithToken:(NSString*)theToken properties:(NSDictionary*)theProperties andRequired:(BOOL)theRequired
{
    if (_useNoFeatures) {
        return;
    }
    
    if (_started == false) {
        [_developerFeatures setObject:[[SLTFeature alloc] initWithToken:theToken properties:theProperties andRequired:theRequired] forKey:theToken];
    } else {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Method 'defineFeature()' should be called before 'start()' only."
                                  userInfo:nil];
        @throw exception;
    }
}

- (void) start
{
    NSException* exception;
    
    if (nil == _deviceId) {
        exception = [NSException
                     exceptionWithName:@"Exception"
                     reason:@"deviceId field is required and can't be null."
                     userInfo:nil];
        @throw exception;
    }
    
    if (0 == [_developerFeatures count] && NO == _useNoFeatures) {
        exception = [NSException
                     exceptionWithName:@"Exception"
                     reason:@"Features should be defined."
                     userInfo:nil];
        @throw exception;
    }
    
    if (0 == [_levelPacks count] && NO == _useNoLevels) {
        exception = [NSException
                     exceptionWithName:@"Exception"
                     reason:@"Levels should be imported."
                     userInfo:nil];
        @throw exception;
    }
    
    NSDictionary* cachedData = [_repository objectFromCache:APP_DATA_URL_CACHE];
    if (nil == cachedData) {
        for(NSString* i in _developerFeatures) {
            [_activeFeatures setObject:[_developerFeatures objectForKey:i] forKey:i];
        }
    } else {
        _activeFeatures = [_deserializer decodeFeaturesFromData:cachedData];
        _experiments = [_deserializer decodeExperimentsFromData:cachedData];
    }
    
    _started = YES;
}

- (void) connect
{
    [self connectWithBasicProperties:nil andCustomProperties:nil];
}

- (void) connectWithBasicProperties:(NSDictionary*)theBasicProperties
{
    [self connectWithBasicProperties:theBasicProperties andCustomProperties:nil];
}

- (void) connectWithBasicProperties:(NSDictionary *)theBasicProperties andCustomProperties:(NSDictionary*)theCustomProperties
{
    if(!_started) {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Method 'connect()' should be called after 'start()' only."
                                  userInfo:nil];
        @throw exception;
    }
    if (_isLoading) {
        [self loadAppDataFailHandler:[[SLTStatusAppDataConcurrentLoadRefused alloc] init]];
        return;
    }
    
    _isLoading = YES;
    
    void (^appDataLoadFailCallback)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        [self loadAppDataFailHandler:[[SLTStatusAppDataLoadFail alloc] init]];
    };
    void (^appDataLoadSuccessCallback)(SLTResource*) = ^(SLTResource* asset) {
        NSDictionary* data = asset.jsonData;
        
        if(nil == data) {
            [asset dispose];
            [self loadAppDataFailHandler:[[SLTStatusAppDataLoadFail alloc] init]];
            return;
        }
        
        BOOL sucess = NO;
        NSDictionary* response = nil;
        
        NSArray* responseData = [data objectForKey:@"response"];
        if(nil != responseData) {
            response = responseData[0];
            sucess = [[response objectForKey:@"success"] boolValue];
        } else {
            response = [data objectForKey:@"responseData"];
            sucess = [[data objectForKey:@"status"] isEqualToString:RESULT_SUCCEED];
        }
        
        _isLoading = NO;
        
        if(sucess) {
            [self loadAppDataSuccessHandler:response];
        } else {
            [self loadAppDataFailHandler:[[SLTStatus alloc] initWithCode:[[response objectForKey:@"errorCode"] integerValue] andMessage:[response objectForKey:@"errorMessage"]]];
        }
        
        [asset dispose];
    };
    
    SLTResource* resource = [self createAppDataResource:appDataLoadSuccessCallback errorHandler:appDataLoadFailCallback basicProperties:theBasicProperties customProperties:theCustomProperties];
    [resource load];
}

-(void) loadLevelContent:(SLTLevel*)level andCacheEnabled:(BOOL)enableCache
{
    NSDictionary* content = nil;
    if(NO == _connected) {
        if (YES == enableCache) {
            content = [self loadLevelContentInternally:level];
        } else {
            content = [self loadLevelContentFromDisk:level];
        }
        [self levelContentLoadSuccessHandler:level data:content];
    } else {
        NSString* cachedVersion = [self cachedLevelVersion:level];
        if (NO == enableCache || [level.version isEqualToString:cachedVersion]) {
            [self loadLevelContentFromSaltr:level];
        } else {
            content = [self loadLevelContentFromCache:level];
            [self levelContentLoadSuccessHandler:level data:content];
        }
    }
}

-(void) addProperties:(NSDictionary*)basicProperties andCustomProperties:(NSDictionary*)theCustomProperties
{
    if ((nil == basicProperties && nil == theCustomProperties)) {
        return;
    }
    
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:API_VERSION forKey:@"apiVersion"];
    [args setObject:_clientKey forKey:@"clientKey"];
    [args setObject:CLIENT forKey:@"client"];
    
    //required for Mobile
    if (nil != _deviceId) {
        [args setObject:_deviceId forKey:@"deviceId"];
    } else {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Field 'deviceId' is a required."
                                  userInfo:nil];
        @throw exception;
    }
    
    //optional
    if (nil != basicProperties) {
        [args setObject:basicProperties forKey:@"basicProperties"];
    }
    
    //optional
    if (nil != theCustomProperties) {
        [args setObject:theCustomProperties forKey:@"customProperties"];
    }
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    void (^syncSuccessHandler)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        NSLog(@"success.");
    };
    void (^syncFailHandler)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        NSLog(@"error.");
    };
    
    if (!error) {
        NSString *jsonArguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonArguments = [jsonArguments stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString* urlVars = [NSString stringWithFormat:@"?cmd=%@&action=%@&args=%@", ACTION_ADD_PROPERTIES, ACTION_ADD_PROPERTIES, jsonArguments];
        
        SLTResourceURLTicket* ticket = [self getTicketWithUrl:SALTR_API_URL urlVars:urlVars andTimeout:_requestIdleTimeout];
        
        SLTResource* resource = [[SLTResource alloc] initWithId:@"property" andTicket:ticket successHandler:syncSuccessHandler errorHandler:syncFailHandler progressHandler:nil];
        [resource load];
    }
}

#pragma mark private functions

-(SLTResource *)createAppDataResource:(void (^)(SLTResource *))appDataAssetLoadCompleteHandler errorHandler:(void (^)(SLTResource *))appDataAssetLoadErrorHandler basicProperties:(NSDictionary*)theBasicProperties customProperties:(NSDictionary*)theCustomProperties
{
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:API_VERSION forKey:@"apiVersion"];
    [args setObject:_clientKey forKey:@"clientKey"];
    [args setObject:CLIENT forKey:@"client"];
    
    //required for Mobile
    if (nil != _deviceId) {
        [args setObject:_deviceId forKey:@"deviceId"];
    } else {
        NSException* exception = [NSException
                     exceptionWithName:@"Exception"
                     reason:@"Field 'deviceId' is a required."
                     userInfo:nil];
        @throw exception;
    }
    
    [args setObject:[self devModeStringValue] forKey:@"devMode"];
    
    //optional for Mobile
    if (nil != _socialId) {
        [args setObject:_socialId forKey:@"socialId"];
    }
    
    if (nil != theBasicProperties) {
        [args setObject:theBasicProperties forKey:@"basicProperties"];
    }
    
    if (nil != theCustomProperties) {
        [args setObject:theCustomProperties forKey:@"customProperties"];
    }
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!error) {
        NSString *jsonArguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonArguments = [jsonArguments stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSString* urlVars = [NSString stringWithFormat:@"?cmd=%@&action=%@&args=%@", ACTION_GET_APP_DATA, ACTION_GET_APP_DATA, jsonArguments];

        SLTResourceURLTicket* ticket = [self getTicketWithUrl:SALTR_API_URL urlVars:urlVars andTimeout:_requestIdleTimeout];
        
        SLTResource* resource = [[SLTResource alloc] initWithId:@"saltAppConfig" andTicket:ticket successHandler:appDataAssetLoadCompleteHandler errorHandler:appDataAssetLoadErrorHandler progressHandler:nil];
        return resource;
    }
    return nil;
}

-(void) loadAppDataSuccessHandler:(NSDictionary *)response {
    
    if(_autoSyncEnabled && !_isDataSynced) {
        [self syncData];
        _isDataSynced = YES;
    }
    
    _levelType = [response objectForKey:@"levelType"];
    NSDictionary* saltrFeatures;
    @try {
        saltrFeatures = [_deserializer decodeFeaturesFromData:response];
    } @catch (NSError* error) {
        [self loadAppDataFailHandler:[[SLTStatusFeaturesParseError alloc] init]];
        return;
    }
    
    @try {
        _experiments = [_deserializer decodeExperimentsFromData:response];
    } @catch (NSError* error) {
        [self loadAppDataFailHandler:[[SLTStatusExperimentsParseError alloc] init]];
        return;
    }
    
    // if developer didn't announce use without levels, and levelType in returned JSON is not "noLevels",
    // then - parse levels
    if (!_useNoLevels && ![_levelType isEqualToString:LEVEL_TYPE_NONE]) {
        NSArray* newLevelPacks;
        @try {
            newLevelPacks = [_deserializer decodeLevelsFromData:response];
        } @catch (NSError* error) {
            [self loadAppDataFailHandler:[[SLTStatusLevelsParseError alloc] init]];
            return;
        }
        
        // if new levels are received and parsed, then only dispose old ones and assign new ones.
        if(nil != newLevelPacks) {
            _levelPacks = newLevelPacks;
        }
    }
    
    _connected = YES;
    [_repository cacheObject:APP_DATA_URL_CACHE version:@"0" object:response];
    
    _activeFeatures = [[NSMutableDictionary alloc] initWithDictionary:saltrFeatures];
    
    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingAppDataRequest)]) {
        [saltrRequestDelegate didFinishGettingAppDataRequest];
    }
    
    NSLog(@"[SALTR] AppData load success. LevelPacks loaded: %i", [_levelPacks count]);
}

-(void) loadAppDataFailHandler:(SLTStatus*)theStatus
{
    _isLoading = NO;
    _connected = NO;
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingAppDataRequest:)]) {
        [saltrRequestDelegate didFailGettingAppDataRequest:theStatus];
    }
}

-(SLTResourceURLTicket*) getTicketWithUrl:(NSString*)theUrl urlVars:(NSString*)theURLVars andTimeout:(NSInteger)theTimeout
{
    SLTResourceURLTicket* ticket = [[SLTResourceURLTicket alloc] initWithURL:theUrl andVariables:theURLVars];
    ticket.method = @"POST";
    if (theTimeout > 0) {
        ticket.idleTimeout=theTimeout;
    }
    return ticket;
}

-(void) syncData
{
    if(!_devMode) {
        return;
    }
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:API_VERSION forKey:@"apiVersion"];
    [args setObject:_clientKey forKey:@"clientKey"];
    [args setObject:CLIENT forKey:@"client"];
    [args setObject:[self devModeStringValue] forKey:@"devMode"];
    
    //required for Mobile
    if (nil != _deviceId) {
        [args setObject:_deviceId forKey:@"deviceId"];
    } else {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Field 'deviceId' is a required."
                                  userInfo:nil];
        @throw exception;
    }
    
    //optional for Mobile
    if (nil != _socialId) {
        [args setObject:_socialId forKey:@"socialId"];
    }
        
    NSMutableArray* featureList = [[NSMutableArray alloc] init];
    for(SLTFeature* feature in _developerFeatures) {
        NSError* featureError = nil;
        NSData *featureData = [NSJSONSerialization dataWithJSONObject:[feature properties]
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&featureError];
        if(!featureError) {
            NSString *featureArguments = [[NSString alloc] initWithData:featureData encoding:NSUTF8StringEncoding];
            featureArguments = [featureArguments stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary* featureDictionary = [[NSDictionary alloc] init];
            [featureDictionary setValue:featureArguments forKey:[feature token]];
            [featureList addObject:featureDictionary];
        } else {
            return;
        }
    }
    [args setObject:featureList forKey:@"developerFeatures"];
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    void (^addDeviceHandler)(NSString*) = ^(NSString* theEmail) {
        [self addDeviceToSaltrWithEmail:theEmail];
    };
    
    void (^syncSuccessHandler)(SLTResource*) = ^(SLTResource* asset) {
        NSDictionary* data = [asset jsonData];
        if(nil == data) {
            NSLog(@"[Slatr Dev feature Sync's response.jsonData is nil.]");
            [asset dispose];
            return;
        }
        NSArray* response = [data objectForKey:@"response"];
        if (nil != response && [response count] > 0 && [[[response objectAtIndex:0] objectForKey:@"registrationRequired"] boolValue]) {
                _dialogController = [[DialogController alloc] initWithUiViewController:_uiViewController andAddDeviceHandler:addDeviceHandler];
            [_dialogController showDeviceRegistrationDialog];
        }
        [asset dispose];
        NSLog(@"[Saltr] Dev feature Sync is complete.");
    };
    void (^syncFailHandler)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        NSLog(@"[Saltr] Dev feature Sync has failed.");
    };
    
    if (!error) {
        NSString *jsonArguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonArguments = [jsonArguments stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString* urlVars = [NSString stringWithFormat:@"?cmd=%@&action=%@&args=%@&devMode=%@", ACTION_DEV_SYNC_DATA, ACTION_DEV_SYNC_DATA, jsonArguments, [self devModeStringValue]];
        if (nil != _deviceId) {
            urlVars = [NSString stringWithFormat:@"?cmd=%@&action=%@&args=%@&devMode=%@&deviceId=%@", ACTION_DEV_SYNC_DATA, ACTION_DEV_SYNC_DATA, jsonArguments, [self devModeStringValue], _deviceId];
        }
        
        SLTResourceURLTicket* ticket = [self getTicketWithUrl:SALTR_DEVAPI_URL urlVars:urlVars andTimeout:_requestIdleTimeout];
        
        SLTResource* resource = [[SLTResource alloc] initWithId:@"syncFeatures" andTicket:ticket successHandler:syncSuccessHandler errorHandler:syncFailHandler progressHandler:nil];
        [resource load];
    }
}

-(void) addDeviceToSaltrWithEmail:(NSString*)theEmail
{
    NSMutableDictionary* args = [[NSMutableDictionary alloc] init];
    [args setObject:API_VERSION forKey:@"apiVersion"];
    [args setObject:_clientKey forKey:@"clientKey"];
    [args setObject:[self devModeStringValue] forKey:@"devMode"];
    
    //required for Mobile
    if (nil != _deviceId) {
        [args setObject:_deviceId forKey:@"id"];
    } else {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Field 'deviceId' is a required."
                                  userInfo:nil];
        @throw exception;
    }
    
    if (nil != theEmail) {
        [args setObject:theEmail forKey:@"email"];
    } else {
        NSException* exception = [NSException
                                  exceptionWithName:@"Exception"
                                  reason:@"Field 'email' is a required."
                                  userInfo:nil];
        @throw exception;
    }
    
    [args setObject:[[UIDevice currentDevice] model] forKey:@"source"];
    [args setObject:[NSString stringWithFormat:@"%@%@", @"iOS ", [[UIDevice currentDevice] systemVersion]] forKey:@"os"];
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:args
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    void (^addDeviceSucessedHandler)(SLTResource*) = ^(SLTResource* asset) {
        NSDictionary* data = [asset jsonData];
        if(nil == data) {
            NSLog(@"[Slatr adding new device response jsonData is nil.]");
            [asset dispose];
            return;
        }
        NSArray* response = [data objectForKey:@"response"];
        if (nil != response && [response count] > 0) {
            NSDictionary* responseObject = [response objectAtIndex:0];
            if (![[responseObject objectForKey:@"success"] boolValue]) {
                NSString* errorMessage = [[responseObject objectForKey:@"error"] objectForKey:@"message"];
                [_dialogController showDeviceRegistrationFailStatus:errorMessage];
            }
        } else {
            [_dialogController showDeviceRegistrationFailStatus:DLG_SUBMIT_FAILED];
        }
        [asset dispose];
        NSLog(@"[Saltr] Dev adding new device is complete.");
    };
    
    void (^addDeviceFailedHandler)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        NSLog(@"[Saltr] Dev adding new device has failed.");
        [_dialogController showDeviceRegistrationFailStatus:DLG_SUBMIT_FAILED];
    };
    
    if (!error) {
        NSString *jsonArguments = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonArguments = [jsonArguments stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString* urlVars = [NSString stringWithFormat:@"?action=%@&args=%@&devMode=%@&id=%@", ACTION_DEV_REGISTER_DEVICE, jsonArguments, [self devModeStringValue], _deviceId];
        
        SLTResourceURLTicket* ticket = [self getTicketWithUrl:SALTR_DEVAPI_URL urlVars:urlVars andTimeout:_requestIdleTimeout];
        
        SLTResource* resource = [[SLTResource alloc] initWithId:@"addDevice" andTicket:ticket successHandler:addDeviceSucessedHandler errorHandler:addDeviceFailedHandler progressHandler:nil];
        [resource load];
    }
}

-(NSDictionary*) loadLevelContentInternally:(SLTLevel*)level
{
    NSDictionary* content = [self loadLevelContentFromCache:level];
    if (nil == content) {
        content = [self loadLevelContentFromDisk:level];
    }
    return content;
}

-(NSDictionary*) loadLevelContentFromDisk:(SLTLevel*)level
{
    NSString* url = LOCAL_LEVEL_CONTENT_PACKAGE_URL_TEMPLATE((long)level.packIndex, (long)level.localIndex);
    return [_repository objectFromApplication:url];
}

-(void) levelContentLoadSuccessHandler:(SLTLevel*)level data:(NSDictionary*)content
{
    [level updateContent:content];
    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingLevelDataRequest)]) {
        [saltrRequestDelegate didFinishGettingLevelDataRequest];
    }
}

-(void) levelContentLoadFailHandler:(SLTStatus*)theStatus
{
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingLevelDataRequest:)]) {
        [saltrRequestDelegate didFailGettingLevelDataRequest:theStatus];
    }
}

-(NSString*) cachedLevelVersion:(SLTLevel*)level
{
    NSString* cachedFileName = LOCAL_LEVEL_CONTENT_CACHE_URL_TEMPLATE((long)level.packIndex, (long)level.localIndex);
    return [_repository objectVersion:cachedFileName];
}

-(void) loadLevelContentFromSaltr:(SLTLevel*)level
{
    NSInteger timeInterval = [NSDate timeIntervalSinceReferenceDate] * 1000;
    NSString* url = [level.contentUrl stringByAppendingFormat:@"?_time_=%li", timeInterval];
    SLTResourceURLTicket* ticket = [self getTicketWithUrl:url urlVars:nil andTimeout:_requestIdleTimeout];
    
    void (^loadInternally)(NSDictionary*) = ^(NSDictionary* contentData) {
        if (contentData) {
            [self levelContentLoadSuccessHandler:level data:contentData];
        } else {
            [self levelContentLoadFailHandler:[[SLTStatusLevelContentLoadFail alloc] init]];
        }
    };
    
    void (^loadFromSaltrSuccessCallback)(SLTResource *) = ^(SLTResource * resource) {
        NSDictionary* contentData = resource.jsonData;
        if (contentData) {
            [self cacheLevelContent:level andContent:contentData];
        } else {
            contentData = [self loadLevelContentInternally:level];
        }
        
        loadInternally(contentData);
        [resource dispose];
        
    };
    
    void (^loadFromSaltrFailCallback)(SLTResource *) = ^(SLTResource * resource) {
        NSDictionary* contentData = [self loadLevelContentInternally:level];
        loadInternally(contentData);
        [resource dispose];
        
    };
        
    SLTResource* resource = [[SLTResource alloc] initWithId:@"saltr" andTicket:ticket successHandler:loadFromSaltrSuccessCallback errorHandler:loadFromSaltrFailCallback progressHandler:nil];
    [resource load];
}

-(NSDictionary*) loadLevelContentFromCache:(SLTLevel*)level
{
    NSString* url = LOCAL_LEVEL_CONTENT_CACHE_URL_TEMPLATE((long)level.packIndex, (long)level.localIndex);
    return [_repository objectFromCache:url];
}

-(void) cacheLevelContent:(SLTLevel *)level andContent:(NSDictionary *)contentData
{
    NSString* cachedFileName = LOCAL_LEVEL_CONTENT_CACHE_URL_TEMPLATE((long)level.packIndex, (long)level.localIndex);
    [_repository cacheObject:cachedFileName version:level.version object:contentData];
}

-(NSString*) devModeStringValue
{
    return _devMode ? @"true" : @"false";
}

@end
