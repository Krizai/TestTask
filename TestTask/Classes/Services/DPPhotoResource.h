//
//  DPApiService.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DPPhotoPage;
@class DPApiService;

@interface DPPhotoResource : NSObject

- (instancetype)initWithApi:(DPApiService*)api;

- (void) loadPhotoPage:(NSUInteger) page
         forSearchText:(NSString*) searchText
            completion:(void(^)(DPPhotoPage* page,NSError* error)) completion;

@end

NS_ASSUME_NONNULL_END
