/*
 * @file
 * SLTAssetState.h
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface SLTAssetState : NSObject

/**
 * The token.
 */
@property (nonatomic, strong, readonly) NSString* token;

/**
 * The properties.
 */
@property (nonatomic, strong, readonly) NSDictionary* properties;

- (id)initWithToken:(NSString*)theToken andProperties:(NSDictionary*)theProperties;

@end