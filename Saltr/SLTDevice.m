/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSDevice.h"

@implementation PSDevice

@synthesize deviceId = _deviceId;
@synthesize deviceType = _deviceType;

-(id) initWithDeviceId:(NSString*)theId andDeviceType:(NSString*)theType
{
    self = [super init];
    if (self) {
        _deviceId = theId;
        //TODO: remove device type after it is removed from Salt Bend
        _deviceType = theType;
    }
    return self;
}

-(NSDictionary *) toDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:_deviceId, @"deviceId", _deviceType, @"deviceType", nil];
}

@end
