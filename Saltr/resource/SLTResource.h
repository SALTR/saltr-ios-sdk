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
#import "PSResourceURLTicket.h"

/**
 * @brief The resource class which keeps the information about ticket, as well as
 * gives opportunity to load/stop and dispose the current resource.
 */

@interface PSResource : NSObject<NSURLConnectionDelegate> {
    
}

/// the resource id
@property (nonatomic, strong, readonly) NSString* id;

/// the ticket for loading the resource
@property (nonatomic, strong, readonly) PSResourceURLTicket* ticket;

/// The count of loaded bytes
@property (nonatomic, assign, readonly) long long bytesLoaded;

/// The total count of bytes
@property (nonatomic, assign, readonly) long long bytesTotal;

/// The percent of loaded bytes.
@property (nonatomic, assign, readonly) NSInteger percentLoaded;

/// The response headers
@property (nonatomic, strong, readonly) NSMutableArray* responseHeaders;

/**
 * @brief Initializes the current resource with the given parameters
 * @param id - the ID of the current resource
 * @param ticket - the ticket of the current resource
 * @param onSuccess - the success handler 
 * @param onFail - the fail handler 
 * @param onProgress - the progress handler
 * @return id - the initialized instance of the current class
 */
-(id) initWithId:(NSString *)id andTicket:(PSResourceURLTicket *)ticket successHandler:(void (^)(PSResource *))onSuccess errorHandler:(void (^)(PSResource *))onFail progressHandler:(void (^)(PSResource *))onProgress;

/// Returns the data of the resource
-(id)data;

/// Returns the json data of the resource
-(NSDictionary *)jsonData;

/// Returns YES, if resource is loaded, otherwise NO.
-(BOOL) isLoaded;

/// Returns the list of response headers
-(NSArray *) responseHeaders;

/// Loads the current resource
-(void) load;

/// Stops the current resource
-(void) stop;

/// Disposes the current resource
-(void) dispose;

@end
