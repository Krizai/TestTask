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
#import "DPSearchHistoryResource.h"

@interface DPSearchFlowController ()<DPSearchHistoryViewControllerDelegate>

@property (nonatomic, strong) UINavigationController* navigationController;
@property (nonatomic, strong) DPPhotoSearchViewController* photoSearchController;

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
        DPPhotoResource* photoResource = [self photoResource];
        DPSearchHistoryResource* searchHistoryResource = [self searchHistoryResource];
        
        DPPhotoSearchViewController* photoSearchController = [[DPPhotoSearchViewController alloc] initWithPhotoResource:photoResource
                                                                                                  searchHistoryResource:searchHistoryResource];
        photoSearchController.title = NSLocalizedString(@"Photo Search", @"Screen titile");
        photoSearchController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"History", nil)
                                                                                                   style:UIBarButtonItemStylePlain target:self action:@selector(historyPressed)];
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:photoSearchController];
        navController.navigationBar.translucent = NO;
        
        
        _navigationController = navController;
        _photoSearchController = photoSearchController;
        
    }
    return self.navigationController;

}

- (DPPhotoResource*) photoResource{
    DPNetworkService* network = [DPNetworkService new];
    DPApiService* api = [[DPApiService alloc] initWithNetwork:network];
    return[[DPPhotoResource alloc] initWithApi:api];
}

- (DPSearchHistoryResource*) searchHistoryResource{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [[DPSearchHistoryResource alloc] initWithUserDefaults:userDefaults];
}

- (void) historyPressed{
    DPSearchHistoryResource* searchHistoryResource = [self searchHistoryResource];

    DPSearchHistoryViewController* historyViewController = [[DPSearchHistoryViewController alloc] initWithSearchHistoryResource:searchHistoryResource];
    historyViewController.delegate = self;
    historyViewController.title = NSLocalizedString(@"History", @"Screen titile");
    [self.navigationController pushViewController:historyViewController animated:YES];
}

#pragma mark DPSearchHistoryViewControllerDelegate

- (void)searchHistoryViewController:(DPSearchHistoryViewController *)controller didSelectItem:(NSString *)item{
    [self.photoSearchController searchFor:item];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
