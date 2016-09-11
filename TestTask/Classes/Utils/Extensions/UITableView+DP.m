//
//  UITableView+DP.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/11/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "UITableView+DP.h"

@implementation UITableView (DP)

- (void)dp_registerCellClass:(Class)cellClass {
    NSString *cellName = NSStringFromClass(cellClass);
    
    UINib *nib = [self dp_nibForClass:cellClass];
    
    if (nib != nil) {
        [self registerNib:nib forCellReuseIdentifier:cellName];
    } else {
        [self registerClass:cellClass forCellReuseIdentifier:cellName];
    }
}

- (id)dp_dequeueReusableCellClass:(Class)cellClass{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    return cell;
}

- (UINib *)dp_nibForClass:(Class)className {
    if (className && [[NSBundle mainBundle] pathForResource:NSStringFromClass(className) ofType:@"nib"] != nil) {
        return [UINib nibWithNibName:NSStringFromClass(className) bundle:nil];
    }
    
    return nil;
}


@end
