//
//  FDDiscoverController.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverController.h"
#import "FDDiscoverCell.h"


@interface FDDiscoverController ()

@end

@implementation FDDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navigationController.tabBarItem.title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FDDiscoverCell *cell = [FDDiscoverCell discoverCellWithTableView:tableView];
    
    return cell;
}





@end
