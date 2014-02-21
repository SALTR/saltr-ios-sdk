//
//  PSExperiment.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSExperiment : NSObject

@property (nonatomic, strong) NSString* partition;
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSArray* customEvents;

@end
