//
//  FDQDiscoverController.m
//  School
//
//  Created by asus on 16/4/27.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQDiscoverController.h"
#import "FDOrganization.h"
#import "FDDiscoverCell.h"
#import "FDJobInfoController.h"
#import "FDJobModel.h"
#import "FDEditJobController.h"
#import "XMPPvCardTemp.h"



@interface FDQDiscoverController ()



@end


@implementation FDQDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
  
}

- (void)setupViews
{
    self.title = self.navigationController.tabBarItem.title;
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addOneJob)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = self.navigationController.tabBarItem.title;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
#pragma mark - uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FDOrganization shareFDOrganization].jobs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    NSArray *array = [FDOrganization shareFDOrganization].jobs;
    FDJobModel *jobModel = array[indexPath.row];
    //新建cell
    FDDiscoverCell *cell = [FDDiscoverCell cellWithTableView:tableView];
    //设置数据
    cell.model = jobModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FDDiscoverCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [FDOrganization shareFDOrganization].jobs;
    FDJobModel *jobModel = array[indexPath.row]; // 获取工作模型数据
    
    FDJobInfoController *vc = [[FDJobInfoController alloc] init];
    vc.title = @"职位详情";
    vc.jobModel = jobModel; //传递数据
    vc.hideBar = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

    //删除一个职位
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[FDOrganization shareFDOrganization].myVcard.jobs];
        [arrayM removeObjectAtIndex:indexPath.row];
    
    //更新到vcard
        [FDOrganization shareFDOrganization].myVcard.jobs = arrayM;

        [[FDOrganization shareFDOrganization] updateMyvCard];
        [self.tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - 公共方法
/**
 *  add一个job，push斤add页面
 */
- (void)addOneJob
{
    FDEditJobController *vc = [[FDEditJobController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 测试用的数据

@end
