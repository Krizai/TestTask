//
//  DPPagingContainer.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPPage;
@interface DPPagingContainer<T> : NSObject

@property (nonatomic, assign, readonly) NSUInteger totalPages;
@property (nonatomic, assign, readonly) NSUInteger pagesLoaded;

@property ( nonatomic, strong, readonly) NSArray<T>* objects;

- (void) clean;
- (void) addPage:(id<DPPage>) page;

@end
