//
//  PSFeature.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSFeature : NSObject

@property (nonatomic, strong, readonly) NSString* token;
@property (nonatomic, strong, readonly, getter = properties) id properties;
@property (nonatomic, strong) id defaultProperties;

/**
 * @brief Inits instance of PSFeature class with given token, properties and default properties
 *
 * @param theToken - feature token
 * @param theDefaultProperties - feature default properties
 * @param theProperties - feature properties
 * @return - The instance of PSFeature class
 */
-(id) initWithToken:(NSString*)theToken defaultProperties:(id)theDefaultProperties andProperties:(id)theProperties;

@end
