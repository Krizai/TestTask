//
//  DPPagingContainer.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPPagingContainer.h"
#import "DPPage.h"

@interface DPPagingContainer<T> ()

@property (nonatomic, assign) NSUInteger totalPages;
@property (nonatomic, assign) NSUInteger pagesLoaded;

@property ( nonatomic, strong) NSArray<T>* objects;

@end

@implementation DPPagingContainer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _objects = @[];
    }
    return self;
}

- (void) clean{
    self.totalPages = 0;
    self.pagesLoaded = 0;
    self.objects = @[];
}
- (void) addPage:(id<DPPage>) page{
    self.totalPages = page.totalPages;
    if(page.objects.count > 0){
        self.pagesLoaded++;
    }
    self.objects = [self.objects arrayByAddingObjectsFromArray:page.objects];
}


@end
