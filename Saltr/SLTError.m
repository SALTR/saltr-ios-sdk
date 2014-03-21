//
//  SLTError.m
//  Saltr
//
//  Created by employee on 3/21/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "SLTError.h"

@implementation SLTError

@synthesize code = _code;
@synthesize message = _message;

- (id)initWithCode:(SLTErrorCode)theCode andMessage:(NSString*)theMessage
{
    self = [super init];
    if (self) {
        _code = theCode;
        _message = theMessage;
    }
    return  self;
}

@end
