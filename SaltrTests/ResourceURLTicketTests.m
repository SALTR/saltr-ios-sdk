//
//  ResourceURLTicketTests.m
//  Saltr
//
//  Created by Gohar Hovhannisyan on 3/4/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PSResourceURLTicket.h"

/// @todo the test case should be revised

@interface ResourceURLTicketTests : XCTestCase {
    PSResourceURLTicket* _ticket;
}

@end

@implementation ResourceURLTicketTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    if (!_ticket) {
        _ticket = [[PSResourceURLTicket alloc] initWithURL:@"http://parliament.am/legislation.php?sel=show&ID=4179&lang=arm" andVariables:nil];
    }
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUrlRequest
{
    NSURLRequest* request = [_ticket urlRequest];
    XCTAssertTrue(request, @"Request getting failed!");
}

- (void)testAddHeader {
    [_ticket addHeader:@"headerName" andHeaderValue:@"headerValue"];
    NSURLRequest* request = [_ticket urlRequest];
    XCTAssertTrue(request, @"Adding HTTP headers to the request failed!");
}

- (void )testHeaderValue {
    [_ticket addHeader:@"headerName" andHeaderValue:@"headerValue"];

    NSString* header = [_ticket headerValue:@"headerName"];
    XCTAssertTrue(header, @"Getting HTTP header with the given name failed!");
}

@end
