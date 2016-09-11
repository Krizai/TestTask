//
//  DPSearchHistoryViewController.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPSearchHistoryResource;
@class DPSearchHistoryViewController;

@protocol DPSearchHistoryViewControllerDelegate <NSObject>

- (void) searchHistoryViewController:(DPSearchHistoryViewController*)controller didSelectItem:(NSString*) item;

@end


@interface DPSearchHistoryViewController : UIViewController

@property ( nonatomic, weak) NSObject<DPSearchHistoryViewControllerDelegate>* delegate;
- (instancetype)initWithSearchHistoryResource:(DPSearchHistoryResource*) searchHistoryResource;

@end
