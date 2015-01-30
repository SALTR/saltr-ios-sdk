/*
 * @file SLTStatus.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

typedef enum  {
    /// Specifies the authorization error.
    AUTHORIZATION_ERROR = 1001,
    
    /// Specifies the validation error.
    VALIDATION_ERROR = 1002,
    
    /// Specifies the API error.
    API_ERROR = 1003,
    
    /// Specifies the parse error.
    PARSE_ERROR = 1004,
    
    /// Specifies the registration required error.
    REGISTRATION_REQUIRED_ERROR_CODE = 2001,
    
    /// Specifies the client error.
    CLIENT_ERROR_CODE = 2002,    
    
    /// Specifies the client app data load fail.
    CLIENT_APP_DATA_LOAD_FAIL = 2040,
    
    /// Specifies the client level content load fail.
    CLIENT_LEVEL_CONTENT_LOAD_FAIL = 2041,
    
    /// Specifies the client app data concurrent load refused.
    CLIENT_APP_DATA_CONCURRENT_LOAD_REFUSED = 2042,
    
    /// Specifies the client features parse error.
    CLIENT_FEATURES_PARSE_ERROR = 2050,
    
    /// Specifies the client experiments parse error.
    CLIENT_EXPERIMENTS_PARSE_ERROR = 2051,
    
    /// Specifies the client levels parse error.
    CLIENT_LEVELS_PARSE_ERROR = 2052
    
} SLTStatusCode;

/// <summary>
/// The SLTStatus class represents the status information of an operation performed by SDK.
/// </summary>
@interface SLTStatus : NSObject

/// The status code.
@property (nonatomic, assign, readonly) SLTStatusCode code;

/// The status message.
@property (nonatomic, strong, readonly) NSString* message;

/**
 * @brief Inits instance of @b SLTStatus class with given code and message.
 *
 * @param theCode The status code.
 * @param theMessage The status message.
 */
- (id)initWithCode:(SLTStatusCode)theCode andMessage:(NSString*)theMessage;

@end