//
//  DPPage.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DPPage <NSObject>

@property (nonatomic, readonly, assign) NSUInteger totalPages;

@property (nonatomic, readonly, strong) NSArray* objects;

@end
