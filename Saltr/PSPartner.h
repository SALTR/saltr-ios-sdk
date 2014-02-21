//
//  PSPartner.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSPartner : NSObject

@property (nonatomic, strong, readonly) NSString* partnerId;
@property (nonatomic, strong, readonly) NSString* partnerType;

/**
 * @brief Inits instance of PSPartner class with given id and type
 *
 * @param theId - partner id
 * @param theType - partner type
 * @return - The instance of PSPartner class
 */
-(id) initWithPartnerId:(NSString*)theId andPartnerType:(NSString*)theType;

@end
