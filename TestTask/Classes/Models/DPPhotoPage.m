//
//  PDPhotosList.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPhotoPage.h"

@interface DPPhotoPage ()

@property (nonatomic, assign) NSUInteger totalPages;

@property (nonatomic, strong) NSArray<DPPhoto>* photos;

@end


@implementation DPPhotoPage

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"photos": @"photo",
                                                                  @"totalPages" : @"pages"}];
}

@end
