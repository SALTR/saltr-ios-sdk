//
//  PSDevice.m
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

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

@end
