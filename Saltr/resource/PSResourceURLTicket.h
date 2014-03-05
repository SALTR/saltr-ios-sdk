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

/// The class is for creating the URL request. The class is created to correspond
// the URLRequest class in action script. @todo uncommented properties do not
// have matches in NSURLRequest class of ios.
@interface PSResourceURLTicket : NSObject {
    
}

@property (nonatomic, assign) BOOL authenticate;
@property (nonatomic, assign) BOOL cacheResponse;
@property (nonatomic, strong) NSString* contentType;

/// The body of HTTP request
@property (nonatomic, strong) NSData* variables;

@property (nonatomic, assign) BOOL followRedirects;


/**
 * @brief The timeout interval, in seconds. If during a connection attempt the request
 * remains idle for longer than the timeout interval, the request is considered to have timed out. The
 * default timeout interval is 60 seconds.
 */
@property (nonatomic, assign) NSInteger idleTimeout;
/// YES if the receiver should use the default cookie handling for the request, NO otherwise. The default is YES
@property (nonatomic, assign) BOOL manageCookies;

/// HTTP request method
@property (nonatomic, strong) NSString* method;

/// HTTP headers
@property (nonatomic, strong) NSMutableDictionary* requestHeaders;

/// the new URL
@property (nonatomic, strong) NSString* url;
@property (nonatomic, assign) BOOL useCache;
@property (nonatomic, strong) NSString* userAgent;
@property (nonatomic, assign) NSInteger maxAttemps;
@property (nonatomic, assign) BOOL checkPolicy;
@property (nonatomic, assign) BOOL useSameDomain;
@property (nonatomic, assign) NSInteger dropTimeout;

/**
 * @brief Initializes the current request with the given parameters
 * @param urlString - the url string of the current request
 * @param variables - the new request body
 * @return - initialized object of the @b PSResourceURLTicket class;
 */
-(id) initWithURL:(NSString *)urlString andVariables:(NSData *)variables;

/// Returns current url request
 -(NSURLRequest *) urlRequest;

/**
 * @brief adds HTTP header to the current request
 * @param headerName - the name of the header to be added the request
 * @param headerValue - the value of the header
 */
-(void) addHeader:(NSString *)headerName andHeaderValue:(NSString *)headerValue;

/**
 * @brief Gets the header with the given name
 * @param headerName - the name of header to be obtained
 * @return - the header value
 */
-(NSString *)headerValue:(NSString *)headerName;

@end
