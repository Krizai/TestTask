//
//  DPSearchFlowController.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPSearchFlowController.h"
#import "DPPhotoSearchViewController.h"
#import "DPSearchHistoryViewController.h"
#import "DPNetworkService.h"
#import "DPApiService.h"
#import "DPPhotoResource.h"

@interface DPSearchFlowController ()

@property (nonatomic, strong) UINavigationController* navigationController;

@end

@implementation DPSearchFlowController
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (UIViewController *)rootSearchViewController{
    if(!_navigationController){
        DPNetworkService* network = [DPNetworkService new];
        DPApiService* api = [[DPApiService alloc] initWithNetwork:network];;
        DPPhotoResource* photoResource = [[DPPhotoResource alloc] initWithApi:api];
        
        DPPhotoSearchViewController* photoSearchController = [[DPPhotoSearchViewController alloc] initWithPhotoResource:photoResource];
        photoSearchController.title = NSLocalizedString(@"Photo Search", @"Screen titile");
        photoSearchController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"History", nil)
                                                                                                   style:UIBarButtonItemStylePlain target:self action:@selector(historyPressed)];
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:photoSearchController];
        navController.navigationBar.translucent = NO;
        
        
        _navigationController = navController;
        
    }
    return self.navigationController;

}


- (void) historyPressed{
    DPSearchHistoryViewController* historyViewController = [[DPSearchHistoryViewController alloc] init];
    historyViewController.title = NSLocalizedString(@"History", @"Screen titile");
    [self.navigationController pushViewController:historyViewController animated:YES];
}



@end
