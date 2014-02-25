//
//  PSSaltr.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSSaltr.h"
#import "PSFeature.h"
#import "PSResource.h"

//
#define APP_DATA_URL_CACHE "app_data_cache.json";
#define APP_DATA_URL_INTERNAL "saltr/app_data.json";
#define LEVEL_DATA_URL_LOCAL_TEMPLATE "saltr/pack_{0}/level_{1}.json";
#define LEVEL_DATA_URL_CACHE_TEMPLATE "pack_{0}_level_{1}.json";

#define RESULT_SUCCEED "SUCCEED";
#define RESULT_ERROR "ERROR";


@interface PSSaltr() {
    BOOL _isLoading;
    /// @todo the meaning of this boolean is not clear yet
    BOOL _ready;
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

-(id) init
{
    self = [super init];
    if (self) {
        self.repository = [PSRepository new];
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

+(PSSaltr *) sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(void) setupPartnerWithId:(NSString *)partnerId andPartnerType:(NSString *)partnerType {
    
}

-(void) setupDeviceWithId:(NSString *)deviceId andDeviceType:(NSString *)deviceType {
    
}

-(void) defineFeatureWithToken:(NSString*)token andProperties:(NSArray *)properties {    
    PSFeature* feature = [features objectForKey:token];
    if (nil == feature) {
        feature = [[PSFeature alloc] initWithToken:token defaultProperties:nil andProperties:properties];
        [features setValue:feature forKey:token];
    } else {
        feature.defaultProperties = properties;
    }
}

-(void) appData {

    if (_isLoading) {
        return;
    }
    _isLoading = true;
    _ready = false;
    PSResource* asset = [self createAppDataResource:appDataAssetLoadCompleteHandler errorHandler:appDataAssetLoadErrorHandler];
//    [asset load];

    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingAppDataRequest)]) {
        [saltrRequestDelegate didFinishGettingAppDataRequest];
    }
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingAppDataRequest)]) {
        [saltrRequestDelegate didFailGettingAppDataRequest];
    }
}

-(void) levelDataBodyWithLevelPack:(PSLevelPackStructure*)levelPackStructure
                    levelStructure:(PSLevelStructure*)levelStructure {
    
    if ([saltrRequestDelegate respondsToSelector:@selector(didFinishGettingLevelDataBodyWithLevelPackRequest)]) {
        [saltrRequestDelegate didFinishGettingLevelDataBodyWithLevelPackRequest];
    }
    if ([saltrRequestDelegate respondsToSelector:@selector(didFailGettingLevelDataBodyWithLevelPackRequest)]) {
        [saltrRequestDelegate didFailGettingLevelDataBodyWithLevelPackRequest];
    }
}

-(void) addPropertyPropertyWithSaltrUserId:(NSString *)saltrUserId
                        andSaltInstanceKey:(NSString *)saltrInstanceKey
                          andPropertyNames:(NSArray *)propertyNames
                         andPropertyValues:(NSArray *)propertyValues
                             andOperations:(NSArray *)operations {
    
}

/// private functions

void (^appDataAssetLoadCompleteHandler)(PSResource*) = ^(PSResource* asset) {
    NSLog(@"[SaltAPI] App data is loaded.");
};

void (^appDataAssetLoadErrorHandler)(PSResource*) = ^(PSResource* asset) {
    NSLog(@"[SaltAPI] App data is failed to load.");
};


-(PSResource *)createAppDataResource:(void (^)(PSResource *))appDataAssetLoadCompleteHandler errorHandler:(void (^)(PSResource *))appDataAssetLoadErrorHandler {
    return [PSResource new];
}

@end
