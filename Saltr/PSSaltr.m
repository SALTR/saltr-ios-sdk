//
//  PSSaltr.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSSaltr.h"

@interface PSSaltr() {
    
    PSRepository* repository;
    
}

@end

@implementation PSSaltr
@synthesize instanceKey;
@synthesize enableCache;

-(id) init {
    self = [super init];
    if (self) {
        repository = [PSRepository new];
    }
    return self;
}

+(id) saltrWith:(NSString *)instanceKey andCacheEnabled:(BOOL)enableCache {
    [PSSaltr sharedInstance].instanceKey = instanceKey;
    [PSSaltr sharedInstance].enableCache = enableCache;
    return [PSSaltr sharedInstance];
}

+ (PSSaltr *)sharedInstance
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

@end
