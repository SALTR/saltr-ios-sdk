//
//  PSPartner.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSPartner.h"

@implementation PSPartner

@synthesize partnerId = _partnerId;
@synthesize partnerType = _partnerType;

-(id) initWithPartnerId:(NSString*)theId andPartnerType:(NSString*)theType
{
    self = [super init];
    if (self) {
        _partnerId = theId;
        _partnerType = theType;
    }
    return self;
}


@end
