/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTPartner.h"

@implementation SLTPartner

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

-(NSDictionary *) toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:_partnerId, @"partnerId", _partnerType, @"partnerType", nil];
}


@end
