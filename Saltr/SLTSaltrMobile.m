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

#pragma mark private functions

@end
