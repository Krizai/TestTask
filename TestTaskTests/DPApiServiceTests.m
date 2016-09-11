//
//  DPApiServiceTests.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/11/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "DPApiService.h"
#import "DPNetworkService.h"
#import "DPPhotoResource.h"
#import "DPPhotoPage.h"
#import "DPPhoto.h"
#import "DPPhotoPageRequest.h"

@interface DPApiServiceTests : XCTestCase

@end

@implementation DPApiServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNil {
    [self executeTestWithInputObject:[NSNull null] inputError:[NSNull null]
                    outputCheckBlock:^(DPPhotoPage *page, NSError *error) {
                        XCTAssertNil(page, @"Wrong page");
                        XCTAssertNotNil(error, @"Nil inputy should produce error");
                    }];
}

- (void)testPage {
    
    NSString* responseString = @"{\"photos\":{\"page\":1,\"pages\":7151,\"perpage\":50,\"total\":\"357510\",\"photo\":[{\"id\":\"29582794805\",\"owner\":\"119707135@N06\",\"secret\":\"783be2ca91\",\"server\":\"8141\",\"farm\":9,\"title\":\"DSC_0099 (1)\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0},{\"id\":\"29472825092\",\"owner\":\"146923606@N07\",\"secret\":\"7170d487bd\",\"server\":\"8504\",\"farm\":9,\"title\":\"Cats\",\"ispublic\":1,\"isfriend\":0,\"isfamily\":0}]},\"stat\":\"ok\"}";
    NSData* responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    id responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    [self executeTestWithInputObject:responseObject inputError:[NSNull null]
                    outputCheckBlock:^(DPPhotoPage *page, NSError *error) {
                        XCTAssertEqual(page.totalPages, 7151);
                        XCTAssertEqual(page.photos.count, 2);
                        DPPhoto* photo1 = page.photos[0];
                        XCTAssert([photo1.photoId isEqual:@"29582794805"]);
                        XCTAssert([photo1.server isEqual: @"8141"]);
                        XCTAssert([photo1.secret isEqual: @"783be2ca91"]);
                        XCTAssert([photo1.farm isEqual: @"9"]);
                        XCTAssertNil(error, @"Nil input should produce error");
                    }];
}

- (void) executeTestWithInputObject:(id) object inputError:(id) error
                   outputCheckBlock:(void(^)(DPPhotoPage* page, NSError* error)) checkBlock{
    
    XCTestExpectation* expectation = [self expectationWithDescription:@"execute"];
    
    id networkMock = OCMClassMock([DPNetworkService class]);
    NSURL* url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?text=Test&page=1&nojsoncallback=1&format=json&api_key=3e7cc266ae2b0e0d78e279ce8e361736&method=flickr.photos.search&per_page=100"];
    OCMStub([networkMock executeRequestToURL:url completion:([OCMArg invokeBlockWithArgs:object, error, nil])]);
    
    DPApiService* api = [[DPApiService alloc] initWithNetwork:networkMock];
    DPPhotoPageRequest* request = [[DPPhotoPageRequest alloc] initWithSearchText:@"Test" page:1];
    
    [api executeRequest:request completion:^(id object, NSError *error) {
        checkBlock(object, error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}



@end
