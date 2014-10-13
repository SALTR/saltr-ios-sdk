/*
 * @file SLTExperiment.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTExperiment.h"

@implementation SLTExperiment

@synthesize partition = _partition;
@synthesize token  = _token;
@synthesize type = _type;
@synthesize customEvents = _customEvents;

- (id)initWithToken:(NSString*)theToken partition:(NSString*)thePartition type:(NSString*)theType andCustomEvents:(NSArray*)theCustomEvents
{
    self = [super init];
    if (self) {
        _partition = thePartition;
        _token = theToken;
        _type = theType;
        _customEvents = theCustomEvents;
    }
    return self;
}

@end
