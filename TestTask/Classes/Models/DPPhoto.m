//
//  PDPhoto.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPhoto.h"

@interface DPPhoto ()


@property ( nonatomic, strong) NSString* photoId;
@property ( nonatomic, strong) NSString* server;
@property ( nonatomic, strong) NSString* secret;
@property ( nonatomic, strong) NSString* farm;

@end


@implementation DPPhoto

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"photoId": @"id"}];
}
@end
