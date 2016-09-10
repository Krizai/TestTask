//
//  DPNetworkService.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPNetworkService.h"
#import <AFNetworking/AFNetworking.h>

@interface DPNetworkService ()

@property ( nonatomic, strong) AFURLSessionManager* manager;

@end

@implementation DPNetworkService

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

- (void) executeRequestToURL:(NSURL*) url
                  completion:(void(^)(id responseObject, NSError* error)) completion{

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    DLog(@"Sending request: %@", url.absoluteString);
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(nil, error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            completion(responseObject, nil);
        }
    }];
    [dataTask resume];
}

@end
