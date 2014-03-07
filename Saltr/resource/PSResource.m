/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSResource.h"

@implementation PSResource {
    NSInteger _countOfFails;
    NSInteger _dropTimeout;
    NSInteger _maxAttempts;
    NSInteger _httpStatus;
    NSTimer* _timeoutTimer;
}

@synthesize id = _id;
@synthesize ticket = _ticket;


-(id) initWithId:(NSString *)id andTicket:(PSResourceURLTicket *)ticket successHandler:(void (^)())onSuccess errorHandler:(void (^)())onFail progressHandler:(void (^)())onProgress {
    self = [super init];
    if (self) {
        _id = id;
        _ticket = ticket;
        _maxAttempts = _ticket.maxAttemps;
        _countOfFails = 0;
        _dropTimeout = _ticket.dropTimeout;
        _httpStatus = -1;
        [self initLoader];
    }
    return self;
}

-(NSInteger) bytesLoaded {
    return 0;
    
}

-(NSInteger) bytesTotal {
    return 0;
}

-(NSInteger) percentLoaded {
    return 0;
}

-(id)data {
    return nil;
}

-(NSDictionary *)jsonData {
    return nil;
}

-(BOOL) isLoaded {
    return NO;
}

-(NSArray *) responseHeaders {
    return nil;
}

-(void) load {
    
}

-(void) stop {
    
}

-(void) dispose {
    
}

#pragma mark private functions

-(void) initLoader {
    
}

@end
