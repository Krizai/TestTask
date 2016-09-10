//
//  DPAlertHelper.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPAlertHelper : NSObject

+ (void)presentFrom:(UIViewController *)viewController
          withTitle:(NSString *)title
            message:(NSString *)message;

+ (void)presentFrom:(UIViewController *)viewController
          withTitle:(NSString *)title
            message:(NSString *)message
            okTitle:(NSString *)okTitle
          okHandler:(void (^)(void))okHandler;

+ (void)presentFrom:(UIViewController *)viewController
          withTitle:(NSString *)title
            message:(NSString *)message
           yesTitle:(NSString *)yesTitle
            noTitle:(NSString *)noTitle
         yesHandler:(void (^)(void)) yesHandler
          noHandler:(void (^)(void))noHandler;


@end
