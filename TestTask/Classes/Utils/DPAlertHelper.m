//
//  DPAlertHelper.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPAlertHelper.h"

@implementation DPAlertHelper


+ (void)presentFrom:(UIViewController *)viewController
          withTitle:(NSString *)title
            message:(NSString *)message {
    [self presentFrom:viewController
            withTitle:title
              message:message
             yesTitle:nil
              noTitle:NSLocalizedString(@"OK", @"OK")
           yesHandler:nil
            noHandler:nil];
}

+ (void)presentFrom:(UIViewController *)viewController
          withTitle:(NSString *)title
            message:(NSString *)message
            okTitle:(NSString *)okTitle
          okHandler:(void (^)(void))okHandler {
    [self presentFrom:viewController
            withTitle:title
              message:message
             yesTitle:nil
              noTitle:okTitle
           yesHandler:nil
            noHandler:okHandler];
}

+ (void)presentFrom:(UIViewController *)viewController
          withTitle:(NSString *)title
            message:(NSString *)message
           yesTitle:(NSString *)yesTitle
            noTitle:(NSString *)noTitle
         yesHandler:(void (^)(void))yesHandler
          noHandler:(void (^)(void))noHandler {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    if (yesTitle) {
        [self addActionWithTitle:yesTitle
                           style:UIAlertActionStyleDefault
                         handler:yesHandler
                    toController:alertController];
    }
    
    [self addActionWithTitle:noTitle
                       style:UIAlertActionStyleCancel
                     handler:noHandler
                toController:alertController];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)addActionWithTitle:(NSString *)title
                     style:(UIAlertActionStyle)style
                   handler:(void (^)(void))handler
              toController:(UIAlertController *)controller {
    
    UIAlertAction *action = [UIAlertAction
                             actionWithTitle:title
                             style:style
                             handler:^(UIAlertAction *action)
                             {
                                 if (handler) {
                                     handler();
                                 }
                             }];
    [controller addAction:action];
}


@end
