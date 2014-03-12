/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface PSPartner : NSObject

/// the partner id
@property (nonatomic, strong, readonly) NSString* partnerId;

/// the partner type
@property (nonatomic, strong, readonly) NSString* partnerType;

/**
 * @brief Inits instance of PSPartner class with given id and type
 *
 * @param theId - partner id
 * @param theType - partner type
 * @return - The instance of PSPartner class
 */
-(id) initWithPartnerId:(NSString*)theId andPartnerType:(NSString*)theType;

/// Returns the dictionary value of @b PSPartner class
-(NSDictionary *) toDictionary;

@end
