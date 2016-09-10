//
//  DPApiService.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPhotoResource.h"
#import "DPApiService.h"
#import "DPPhotoPage.h"
#import "DPPhotoPageRequest.h"

@interface DPPhotoResource ()

@property ( nonatomic, strong) DPApiService* api;

@end

@implementation DPPhotoResource

- (instancetype)initWithApi:(DPApiService*)api
{
    self = [super init];
    if (self) {
        _api = api;
    }
    return self;
}

- (void) loadPhotoPage:(NSUInteger) page
         forSearchText:(NSString*) searchText
            completion:(void(^)(DPPhotoPage* page, NSError* error)) completion{
    
    DPPhotoPageRequest* request = [[DPPhotoPageRequest alloc] initWithSearchText:searchText page:page];
    [self.api executeRequest:request completion:^(id object, NSError *error) {
        completion(object, error);
    }];
}
@end
