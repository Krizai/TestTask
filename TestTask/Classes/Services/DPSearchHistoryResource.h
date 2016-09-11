//
//  DPSearchHistoryResource.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/11/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPSearchHistoryResource : NSObject

- (instancetype)initWithUserDefaults:(NSUserDefaults*) defaults;


- (NSArray<NSString*>*) getHistoryList;
- (void) addHistoryItem:(NSString*) item;

@end
