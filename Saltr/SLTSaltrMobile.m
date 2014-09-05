/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTSaltrMobile.h"

#import "SLTDummyRepository.h"
#import "SLTLevelPack.h"
#import "SLTLevel.h"
#import "SLTFeature.h"
#import "SLTConfig.h"
#import "SLTDeserializer.h"
#import "SLTResource.h"
#import "SLTResourceURLTicket.h"
#import "SLTStatusAppDataLoadFail.h"

NSString* CLIENT=@"IOS-Mobile";
NSString* API_VERSION=@"1.0.1";

@interface SLTSaltrMobile() {    
    NSString* _clientKey;
    NSString* _deviceId;
    BOOL _isLoading;
    BOOL _connected;
    NSString* _saltrUserId;
    BOOL _useNoLevels;
    BOOL _useNoFeatures;
    NSString* _levelType;
    BOOL _devMode;
    BOOL _started;
    NSInteger _requestIdleTimeout;
    NSMutableDictionary* _activeFeatures;
    NSMutableDictionary* _developerFeatures;
    //NSArray* _experiments;
    //NSArray* _levelPacks;
    NSObject<SLTRepositoryProtocolDelegate>* _repository;
    SLTDeserializer* _deserializer;
}
@end

@implementation SLTSaltrMobile

@synthesize saltrRequestDelegate;
@synthesize repository  = _repository;
@synthesize useNoLevels  = _useNoLevels;
@synthesize useNoFeatures  = _useNoFeatures;
@synthesize devMode  = _devMode;
@synthesize requestIdleTimeout  = _requestIdleTimeout;
@synthesize levelPacks  = _levelPacks;
@synthesize experiments  = _experiments;
@synthesize socialId  = _socialId;

- (id) initSaltrWithClientKey:(NSString*)theClientKey deviceId:(NSString*)theDeviceId andCacheEnabled:(BOOL)theCacheEnabled
{
    self = [super init];
    if (self) {
        _clientKey = theClientKey;
        _deviceId = theDeviceId;
        _isLoading = NO;
        _connected = NO;
        _saltrUserId = nil;
        _useNoLevels = NO;
        _useNoFeatures = NO;
        _levelType = nil;
        
        _devMode = NO;
        _started = NO;
        _requestIdleTimeout = 0;
        
        _activeFeatures = [[NSMutableDictionary alloc] init];
        _developerFeatures = [[NSMutableDictionary alloc] init];
        //_experiments = [[NSMutableArray alloc] init];
        //_levelPacks = [[NSMutableArray alloc] init];
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
    
    if (_started == false) {
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
        _saltrUserId = [cachedData objectForKey:@"saltrUserId"];
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
    if (_isLoading || !_started) {
        return;
    }
    
    _isLoading = YES;
    
    void (^appDataLoadFailCallback)(SLTResource*) = ^(SLTResource* asset) {
        [asset dispose];
        [self loadAppDataFailHandler];
    };
    void (^appDataLoadSuccessCallback)(SLTResource*) = ^(SLTResource* asset) {
        //TODO: @Tigr implement
//        NSDictionary* data = asset.jsonData;
//        NSDictionary* jsonData = [data objectForKey:@"responseData"];
//        NSString* status = [data objectForKey:@"status"];
//        assert(status);
//        _isLoading = NO;
//        if ([status isEqualToString:RESULT_SUCCEED]) {
//            [_repository cacheObject:APP_DATA_URL_CACHE version:@"0" object:jsonData];
//            _connected = YES;
//            [self loadAppDataSuccessHandler:jsonData];
//        } else {
////            [self loadAppDataFailHandlerWithErrorCode:[[jsonData objectForKey:@"errorCode"] integerValue]  andMessage:[jsonData objectForKey:@"errorMessage"]];
//        }
//        [asset dispose];
    };
    
    SLTResource* resource = [self createAppDataResource:appDataLoadSuccessCallback errorHandler:appDataLoadFailCallback basicProperties:theBasicProperties customProperties:theCustomProperties];
    [resource load];
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
    
    //optional for Mobile
    if (nil != _socialId) {
        [args setObject:_socialId forKey:@"socialId"];
    }
    
    //optional
    if (nil != _saltrUserId) {
        [args setObject:_saltrUserId forKey:@"saltrUserId"];
    }
    
    if (nil != theBasicProperties) {
        [args setObject:theBasicProperties forKey:@"basicProperties"];
    }
    
    if (nil != theCustomProperties) {
        [args setObject:theCustomProperties forKey:@"customProperties"];
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    
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
    
    ////////////////////////////////////////////////////////////////////////////////
    
    //SLTResourceURLTicket* ticket = [[SLTResourceURLTicket alloc] initWithURL:SALTR_API_URL andVariables:urlVars];
    
    //return nil;
}

-(void) loadAppDataSuccessHandler:(NSDictionary *)jsonData {
    //TODO: @TIGR implement
//    _saltrUserId = [jsonData objectForKey:@"saltId"];
//    _experiments = [_deserializer decodeExperimentsFromData:jsonData];
//    _levelPacks = [_deserializer decodeLevelsFromData:jsonData];
//    NSDictionary* saltrFeatures = [_deserializer decodeFeaturesFromData:jsonData];
//    //merging with defaults...
//    
//    for (NSString* key in [saltrFeatures allKeys]) {
//        SLTFeature* saltrFeature = [saltrFeatures objectForKey:key];
//        SLTFeature* defaultFeature = [_features objectForKey:key];
//        saltrFeature.defaultProperties = defaultFeature.defaultProperties;
//        [_features setValue:saltrFeature forKey:key];
//    }
//    
//    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingAppDataRequest)]) {
//        [saltrRequestDelegate didFinishGettingAppDataRequest];
//    }
//    /// @todo the meaning of the boolean below is not clear.
//    // The condition will be always true as the mentioned boolean never changes its value.
//    if (_isInDevMode) {
//        [self syncFeatures];
//    }
}

-(void) loadAppDataFailHandler
{
    _isLoading = NO;
    _connected = NO;
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingAppDataRequest:)]) {
        SLTStatusAppDataLoadFail* status = [[SLTStatusAppDataLoadFail alloc] init];
        [saltrRequestDelegate didFailGettingAppDataRequest:status];
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

@end
