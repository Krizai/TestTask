//
//  DPSearchHistoryViewController.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPSearchHistoryViewController.h"

@interface DPSearchHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DPSearchHistoryViewController


#pragma mark UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
