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

@implementation PSResource
@synthesize id = _id;
@synthesize ticket = _ticket;

-(id) initWithId:(NSString *)id andTicket:(PSResourceURLTicket *)ticket {
    self = [super init];
    if (self) {
        _id = id;
        _ticket = ticket;
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

-(id)jsonData {
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

@end
