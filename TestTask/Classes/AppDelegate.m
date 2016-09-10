//
//  AppDelegate.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "AppDelegate.h"
#import "DPPhotoSearchViewController.h"
#import "DPNetworkService.h"
#import "DPApiService.h"
#import "DPPhotoResource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DPNetworkService* network = [DPNetworkService new];
    DPApiService* api = [[DPApiService alloc] initWithNetwork:network];;
    DPPhotoResource* photoResource = [[DPPhotoResource alloc] initWithApi:api];
    
    DPPhotoSearchViewController* photoSearchController = [[DPPhotoSearchViewController alloc] initWithPhotoResource:photoResource];
    photoSearchController.title = NSLocalizedString(@"Photo Search", @"Screen titile");
    photoSearchController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"History", nil)
                                                                                               style:UIBarButtonItemStylePlain target:self action:@selector(historyPressed)];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:photoSearchController];
    navController.navigationBar.translucent = NO;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void) historyPressed{
    
}


@end
