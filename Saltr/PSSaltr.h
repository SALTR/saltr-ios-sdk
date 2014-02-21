//
//  PSSaltr.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSRepository.h"

@interface PSSaltr : NSObject

@property (nonatomic, strong, readonly) NSString* instanceKey;
@property (nonatomic, assign) BOOL enableCache;

/**
 * @brief Initializes Saltr class wit hthe givn instanceKey and enableCache flag
 * @param instanceKey - the initialization key
 * @param enableCache - YES, if caching should be enabled, otherwise NO
 * @return - The only instance of Saltr class
 */
+(id) saltrWithInstanceKey:(NSString *)instanceKey andCacheEnabled:(BOOL)enableCache;

/// Returns the only instance of Saltr class
+ (PSSaltr *)sharedInstance;

@end

