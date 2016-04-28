//
//  FDApplyResumeInfoController.m
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDApplyResumeInfoController.h"
#import "FDResume.h"
#import "FDResumeInfoCell.h"
#import "FDOrganization.h"


@interface FDApplyResumeInfoController ()

@end

@implementation FDApplyResumeInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FDOrganization shareFDOrganization].allResume.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDResumeInfoCell *cell = [FDResumeInfoCell cellForTableView:tableView];
    
    return cell;
}


@end
