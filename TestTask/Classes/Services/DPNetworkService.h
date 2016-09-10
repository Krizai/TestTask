//
//  DPNetworkService.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPNetworkService : NSObject

- (void) executeRequestToURL:(NSURL*) url
                  completion:(void(^)(id responseObject, NSError* error)) completion;

@end
