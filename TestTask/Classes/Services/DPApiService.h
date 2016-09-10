//
//  DPApiService.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPNetworkService;
@protocol DPApiRequest;
@interface DPApiService : NSObject

- (instancetype)initWithNetwork:(DPNetworkService*)network;

- (void) executeRequest:(id<DPApiRequest>) request
                  completion:(void(^)(id object, NSError* error)) completion;

@end
