//
//  DPApiService.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPApiService.h"
#import "DPApiRequest.h"
#import "DPApiResponseParser.h"
#import "DPNetworkService.h"

static NSString* const DPApiServiceBaseUrl = @"https://api.flickr.com/services/rest/";

@interface DPApiService ()

@property ( nonatomic, strong) DPNetworkService* network;

@end

@implementation DPApiService

- (instancetype)initWithNetwork:(DPNetworkService*)network
{
    self = [super init];
    if (self) {
        _network = network;
    }
    return self;
}

- (void) executeRequest:(id<DPApiRequest>) request
             completion:(void(^)(id object, NSError* error)) completion{
    NSURL* url = [self urlForRequest:request];
    [self.network executeRequestToURL:url completion:^(id responseObject, NSError *error) {
        if(error){
            completion(nil, error);
            return;
        }
        NSError* parsingError = nil;
        id result = [[request parser] parse:responseObject error:&parsingError];
        
        completion(result, parsingError);
    }];
}


-(NSURL*) urlForRequest:(id<DPApiRequest>) request{
    NSMutableDictionary<NSString*, NSString*>* parameters = [NSMutableDictionary new];
    parameters[@"method"] = [request method];
    parameters[@"api_key"] = @"3e7cc266ae2b0e0d78e279ce8e361736";
    parameters[@"format"] = @"json";
    parameters[@"nojsoncallback"] = @"1";
    NSDictionary* requestParameters = [request parameters];
    if(requestParameters){
        [parameters addEntriesFromDictionary:requestParameters];
    }
    
    NSString* parametersString = [self urlParametersStringFor:parameters];
    
    NSString* urlString = [NSString stringWithFormat:@"%@?%@", DPApiServiceBaseUrl, parametersString];
    
    return [NSURL URLWithString:urlString];
}

-(NSString*) urlParametersStringFor:(NSDictionary<NSString*, NSString*>*) methodParameters{
    NSMutableString* result = [NSMutableString new];
    __block BOOL isFirst = YES;
    [methodParameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if(!isFirst){
            [result appendString:@"&"];
        }
        [result appendFormat:@"%@=%@", key, obj];
        isFirst = NO;
    }];
    return result;
}

@end
