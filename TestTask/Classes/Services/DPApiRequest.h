//
//  DPApiRequest.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPApiResponseParser;
@protocol DPApiRequest <NSObject>

- (NSString*) method;
- (NSDictionary<NSString*, NSString*>*) parameters;
- (id<DPApiResponseParser>) parser;

@end
