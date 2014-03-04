/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSResourceURLTicket.h"

@implementation PSResourceURLTicket

@synthesize authenticate= _authenticate;
@synthesize cacheResponse=_cacheResponse;
@synthesize contentType=_contentType;
@synthesize variables=_variables;
@synthesize followRedirects=_followRedirects;
@synthesize idleTimeout=_idleTimeout;
@synthesize manageCookies=_manageCookies;
@synthesize method=_method;
@synthesize requestHeaders=_requestHeaders;
@synthesize url=_url;
@synthesize useCache=_useCache;
@synthesize userAgent=_userAgent;
@synthesize maxAttemps=_maxAttemps;
@synthesize checkPolicy=_checkPolicy;
@synthesize useSameDomain=_useSameDomain;
@synthesize dropTimeout=_dropTimeout;

-(id) initWithURL:(NSString *)urlString andVariables:(NSData *)variables {
    self = [super init];
    if (self) {
        _url = urlString;
        _variables = variables;
        _authenticate = YES;
        _cacheResponse = YES;
        _followRedirects = YES;
        _manageCookies = YES;
        _useCache = YES;
        _idleTimeout = 0;
        _method = @"GET";
        _checkPolicy = NO;
        _maxAttemps = 3;
        _useSameDomain = YES;
        _dropTimeout = 0;

    }
    return self;
}

-(NSURLRequest *) urlRequest {
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_url]];
    request.timeoutInterval = _idleTimeout;
    [request setHTTPShouldHandleCookies:_manageCookies];
    [request setHTTPMethod:_method];
    [request setHTTPBody:_variables];
    [request setAllHTTPHeaderFields:_requestHeaders];
    return request;
}

-(void) addHeader:(NSString *)headerName andHeaderValue:(NSString *)headerValue {
    [_requestHeaders setValue:headerName forKey:headerValue];
}

-(NSString *)headerValue:(NSString *)headerName {
    for (NSDictionary* requestHeader in _requestHeaders) {
        if ([[requestHeader allKeys] containsObject:headerName]) {
            return [requestHeader valueForKey:headerName];
        }
    }
    return nil;
}

@end
