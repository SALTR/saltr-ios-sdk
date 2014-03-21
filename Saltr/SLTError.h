//
//  SLTError.h
//  Saltr
//
//  Created by employee on 3/21/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    AUTHORIZATION_ERROR_CODE = 1001,
    VALIDATION_ERROR_CODE = 1002,
    API_ERROR_CODE = 1003,
    GENERAL_ERROR_CODE = 2001,
    CLIENT_ERROR_CODE = 2002
} SLTErrorCode;

/**
 * The private interface of game @b SLTError class.
 */
@interface SLTError : NSObject

/// The code of error
@property (nonatomic, assign, readonly) SLTErrorCode code;

/// The message of error
@property (nonatomic, strong, readonly) NSString* message;

/**
 * @brief Inits instance of @b SLTError class with given code and message
 *
 * @param theCode - the code of error
 * @param theMessage - the message of error
 * @return - The instance of @b SLTError class
 */
- (id)initWithCode:(SLTErrorCode)theCode andMessage:(NSString*)theMessage;

@end