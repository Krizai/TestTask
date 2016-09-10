//
//  AppDelegate.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/9/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "AppDelegate.h"
#import "DPSearchFlowController.h"

@interface AppDelegate ()

@property (nonatomic, strong) DPSearchFlowController* flowController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.flowController = [DPSearchFlowController new];
    
    self.window.rootViewController = self.flowController.rootSearchViewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
