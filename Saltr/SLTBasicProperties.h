/*
 * @file
 * SLTBasicProperties.h
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface SLTBasicProperties : NSObject

/// The age
@property (nonatomic, assign, readwrite) NSUInteger age;

/// The gender "F", "M", "female", "male"
@property (nonatomic, strong, readwrite) NSString* gender;

/// The name of the OS the current device is running. E.g. iPhone OS.
@property (nonatomic, strong, readwrite) NSString* systemName;

/// The version number of the OS the current device is running. E.g. 6.0.
@property (nonatomic, strong, readwrite) NSString* systemVersion;

/// The name of the browser the current device is running. E.g. Chrome.
@property (nonatomic, strong, readwrite) NSString* browserName;

/// The version number of the browser the current device is running. E.g. 17.0.
@property (nonatomic, strong, readwrite) NSString* browserVersion;

/// A human-readable name representing the device.
@property (nonatomic, strong, readwrite) NSString* deviceName;

/// The Type name of the device. E.g. iPad.
@property (nonatomic, strong, readwrite) NSString* deviceType;

/// The current locale the user is in. E.g. en_US.
@property (nonatomic, strong, readwrite) NSString* locale;

/**
 * The country the user is in, specified by ISO 2-letter code. E.g. US for United States.
 * Set to (locate) to detect the country based on the IP address of the caller.
 */
@property (nonatomic, strong, readwrite) NSString* country;

/**
 * The region (state) the user is in. E.g. ca for California.
 * Set to (locate) to detect the region based on the IP address of the caller.
 */
@property (nonatomic, strong, readwrite) NSString* region;

/**
 * The city the user is in. E.g. San Francisco.
 * Set to (locate) to detect the city based on the IP address of the caller.
 */
@property (nonatomic, strong, readwrite) NSString* city;

/**
 * The location (latitude/longitude) of the user. E.g. 37.775,-122.4183.
 * Set to (locate) to detect the location based on the IP address of the caller.
 */
@property (nonatomic, strong, readwrite) NSString* location;

/// Version of the client app, e.g. 4.1.1
@property (nonatomic, strong, readwrite) NSString* appVersion;

- (id)init;

@end
