/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTResource.h"

@implementation SLTResource {
    NSInteger _countOfFails;
    
    /// @todo Not clear yet why timer is needed?
    BOOL _isLoaded;
    NSInteger _dropTimeout;
    NSTimer* _timeoutTimer;

    NSInteger _maxAttempts;
    NSInteger _httpStatus;
    NSMutableData* _responseData;
    NSURLConnection* _urlLoader;
    BOOL _finished;
    void (^_onSuccess)(SLTResource *);
    void (^_onFail)(SLTResource *);
    void (^_onProgress)(long long, long long, long long);
}

@synthesize id = _id;
@synthesize ticket = _ticket;
@synthesize bytesLoaded = _bytesLoaded;
@synthesize bytesTotal = _bytesTotal;
@synthesize percentLoaded = _percentLoaded;
@synthesize responseHeaders = _responseHeaders;
    
    
-(id) initWithId:(NSString *)id andTicket:(SLTResourceURLTicket *)ticket successHandler:(void (^)(SLTResource *))onSuccess errorHandler:(void (^)(SLTResource *))onFail progressHandler:(void (^)(long long, long long, long long))onProgress {
    self = [super init];
    if (self) {
        _id = id;
        _ticket = ticket;
        _maxAttempts = _ticket.maxAttemps;
        _countOfFails = 0;
        _dropTimeout = _ticket.dropTimeout;
        
        /// @todo NO HTTP status code is needed, as if request fails, - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error delegate method will be called
        _httpStatus = -1;
        _onSuccess = onSuccess;
        _onFail = onFail;
        _onProgress = onProgress;
        _responseHeaders = [NSDictionary new];
        _finished = NO;
        _isLoaded = NO;
        [self initLoader];
    }
    return self;
}

-(NSData *)data {
    return _responseData;
}

-(NSDictionary *)jsonData {
    NSError* error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"JSONObjectWithData error: %@", error);
        return nil;
    }
    return dictionary;
}

-(BOOL) isLoaded {
    return _isLoaded;
}

-(NSDictionary *) responseHeaders {
    return _responseHeaders;
}

-(void) load {
    ++_countOfFails;
    [_urlLoader start];
    while(!_finished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

-(void) stop {
    [_urlLoader cancel];
}

-(void) dispose {
    _urlLoader = nil;
}

#pragma mark private functions

-(void) initLoader {
    _urlLoader = [[NSURLConnection alloc] initWithRequest:_ticket.urlRequest delegate:self startImmediately:NO];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
    _bytesTotal = response.expectedContentLength;
    _responseHeaders = [response allHeaderFields];
    _httpStatus = [response statusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    _bytesLoaded += [data length];
    _percentLoaded = round(_bytesLoaded / _bytesTotal * 100);
    _onProgress(_bytesLoaded, _bytesTotal, _percentLoaded);

    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    _finished = YES;

    _isLoaded = YES;
    _onSuccess(self);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    if (_countOfFails == _maxAttempts) {
        _onFail(self);
        _isLoaded = NO;
    } else {
        [self load];
    }
}

@end
