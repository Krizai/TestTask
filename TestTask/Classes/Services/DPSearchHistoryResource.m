//
//  DPSearchHistoryResource.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/11/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPSearchHistoryResource.h"

static NSString* const DPSearchHistoryResourceDefaultsKey = @"DPSearchHistoryResourceDefaultsKey";
static NSUInteger const DPSearchHistoryMaxLength = 100;

@interface DPSearchHistoryResource ()

@property ( nonatomic, strong, readonly) NSUserDefaults* defaults;

@end

@implementation DPSearchHistoryResource

- (instancetype)initWithUserDefaults:(NSUserDefaults*) defaults
{
    self = [super init];
    if (self) {
        _defaults = defaults;
    }
    return self;
}

- (NSArray<NSString*>*) getHistoryList{
    NSArray<NSString*>* historyList = [self.defaults stringArrayForKey:DPSearchHistoryResourceDefaultsKey];
    return historyList ?: @[];
}

- (void) addHistoryItem:(NSString*) item{
    NSMutableArray<NSString*>* historyList = [self getHistoryList].mutableCopy;
    [historyList insertObject:item atIndex:0];
    if(historyList.count > DPSearchHistoryMaxLength){
        [historyList removeLastObject];
    }
    [self.defaults setValue:historyList forKey:DPSearchHistoryResourceDefaultsKey];
}


@end
