/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSResource.h"

@implementation PSResource {
    NSInteger _countOfFails;
    NSInteger _dropTimeout;
    NSInteger _maxAttempts;
    NSInteger _httpStatus;
    NSTimer* _timeoutTimer;
    NSMutableData* _responseData;
    NSURLConnection* _urlLoader;
    BOOL finished;
    void (^_onSuccess)(PSResource *);
    void (^_onFail)(PSResource *);
    void (^_onProgress)(PSResource *);
}

@synthesize id = _id;
@synthesize ticket = _ticket;
@synthesize bytesLoaded = _bytesLoaded;
@synthesize bytesTotal = _bytesTotal;
@synthesize percentLoaded = _percentLoaded;
@synthesize responseHeaders = _responseHeaders;
    
    
-(id) initWithId:(NSString *)id andTicket:(PSResourceURLTicket *)ticket successHandler:(void (^)(PSResource *))onSuccess errorHandler:(void (^)(PSResource *))onFail progressHandler:(void (^)(PSResource *))onProgress {
    self = [super init];
    if (self) {
        _id = id;
        _ticket = ticket;
        _maxAttempts = _ticket.maxAttemps;
        _countOfFails = 0;
        _dropTimeout = _ticket.dropTimeout;
        _httpStatus = -1;
        _onSuccess = onSuccess;
        _onFail = onFail;
        _onProgress = onProgress;
        _responseHeaders = [NSMutableArray new];
        finished = NO;
        [self initLoader];
    }
    return self;
}

-(id)data {
    return nil;
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
    return NO;
}

-(NSArray *) responseHeaders {
    return nil;
}

-(void) load {
    [_urlLoader start];
    while(!finished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

-(void) stop {
    
}

-(void) dispose {
    
}

#pragma mark private functions

-(void) initLoader {
    _urlLoader = [[NSURLConnection alloc] initWithRequest:_ticket.urlRequest delegate:self startImmediately:NO];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
    _bytesTotal = response.expectedContentLength;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    _bytesLoaded += [data length];
//    _onProgress(self);
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
    finished = YES;

    _onSuccess(self);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    _onFail(self);
}


@end
