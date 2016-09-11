//
//  TestTaskTests.m
//  TestTaskTests
//
//  Created by Dmitry Povolotsky on 9/11/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "DPApiService.h"
#import "DPPhotoResource.h"
#import "DPPhotoPage.h"

@interface DPPhotoResourceTests : XCTestCase

@end

@implementation DPPhotoResourceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNil {
    
    [self executeTestWithInputObject:[NSNull null] inputError:[NSNull null] outputCheckBlock:^(DPPhotoPage *page, NSError *error) {
        XCTAssertNil(page, @"Wrong page");
        XCTAssertNil(error, @"Wrong error");
    }];

}

- (void)testPage {
    
    DPPhotoPage* pageMock = [DPPhotoPage new];
    [self executeTestWithInputObject:pageMock inputError:[NSNull null] outputCheckBlock:^(DPPhotoPage *page, NSError *error) {
        XCTAssertEqual(pageMock, page, @"Wrong page");
        XCTAssertNil(error, @"Wrong error");
    }];

}

- (void)testError {
    NSError* errorMock = [NSError new];
    [self executeTestWithInputObject:[NSNull null] inputError:errorMock outputCheckBlock:^(DPPhotoPage *page, NSError *error) {
        XCTAssertNil(page, @"Wrong page");
        XCTAssertEqual(errorMock, error, @"Wrong error");
    }];
}

- (void) executeTestWithInputObject:(id) object inputError:(id) error
                   outputCheckBlock:(void(^)(DPPhotoPage* page, NSError* error)) checkBlock{
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"load photos"];
    
    id apiMock = OCMClassMock([DPApiService class]);
    OCMStub([apiMock executeRequest:[OCMArg any] completion:([OCMArg invokeBlockWithArgs:object, error, nil])]);
    
    DPPhotoResource* photo = [[DPPhotoResource alloc] initWithApi:apiMock];
    
    [photo loadPhotoPage:0 forSearchText:@"Any" completion:^(DPPhotoPage *  page, NSError * error) {
        checkBlock(page, error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}




@end
