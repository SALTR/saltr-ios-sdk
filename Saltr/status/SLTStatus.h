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

typedef enum  {
    AUTHORIZATION_ERROR = 1001,
    VALIDATION_ERROR = 1002,
    API_ERROR = 1003,
    
    GENERAL_ERROR_CODE = 2001,
    CLIENT_ERROR_CODE = 2002,    
    
    CLIENT_APP_DATA_LOAD_FAIL = 2040,
    CLIENT_LEVEL_CONTENT_LOAD_FAIL = 2041,
    
    CLIENT_FEATURES_PARSE_ERROR = 2050,
    CLIENT_EXPERIMENTS_PARSE_ERROR = 2051,
    CLIENT_LEVELS_PARSE_ERROR = 2052
    
} SLTStatusCode;


@interface SLTStatus : NSObject

/// The code of error
@property (nonatomic, assign, readonly) SLTStatusCode code;

/// The message of error
@property (nonatomic, strong, readonly) NSString* message;

/**
 * @brief Inits instance of @b SLTStatus class with given code and message
 *
 * @param theCode - the code of status
 * @param theMessage - the message of status
 * @return - The instance of @b SLTStatus class
 */
- (id)initWithCode:(SLTStatusCode)theCode andMessage:(NSString*)theMessage;

@end