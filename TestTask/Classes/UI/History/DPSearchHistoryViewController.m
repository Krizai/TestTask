//
//  DPSearchHistoryViewController.m
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#import "DPSearchHistoryViewController.h"
#import "DPSearchHistoryResource.h"
#import "UITableView+DP.h"

@interface DPSearchHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic, readonly) DPSearchHistoryResource* searchHistoryResource;

@property ( nonatomic, strong) NSArray<NSString*>* historyList;

@end

@implementation DPSearchHistoryViewController


- (instancetype)initWithSearchHistoryResource:(DPSearchHistoryResource*) searchHistoryResource
{
    self = [super init];
    if (self) {
        _searchHistoryResource = searchHistoryResource;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView dp_registerCellClass:[UITableViewCell class]];
    
    self.historyList = [self.searchHistoryResource getHistoryList];
}


#pragma mark UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* historyItem = self.historyList[indexPath.row];
    
    UITableViewCell* cell = [tableView dp_dequeueReusableCellClass:[UITableViewCell class]];
    cell.textLabel.text = historyItem;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* historyItem = self.historyList[indexPath.row];
    
    [self.delegate searchHistoryViewController:self didSelectItem:historyItem];
}

@end
