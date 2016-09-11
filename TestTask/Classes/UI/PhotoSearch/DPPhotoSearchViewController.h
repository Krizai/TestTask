//
//  DPPhotoSearchViewController.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPPhotoResource;
@class DPSearchHistoryResource;

@interface DPPhotoSearchViewController : UIViewController

- (instancetype)initWithPhotoResource:(DPPhotoResource*) photoResource
                searchHistoryResource:(DPSearchHistoryResource*) searchHistoryResource;


-(void)searchFor:(NSString*) searchItem;

@end
