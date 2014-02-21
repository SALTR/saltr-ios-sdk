//
//  PSDevice.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSDevice : NSObject

@property (nonatomic, strong, readonly) NSString* deviceId;
@property (nonatomic, strong, readonly) NSString* deviceType;

/**
 * @brief Inits instance of PSDevice class with given id and type
 *
 * @param theId - device id
 * @param theType - device type
 * @return - The instance of PSDevice class
 */
-(id) initWithDeviceId:(NSString*)theId andDeviceType:(NSString*)theType;

@end
