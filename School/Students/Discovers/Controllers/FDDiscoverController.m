//
//  FDDiscoverController.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverController.h"
#import "FDDiscoverController+FDCoreDataExtension.h"
#import "FDDiscoverCell.h"
#import "FDJobInfoController.h"
#import "FDContactModel.h"
#import "XMPPvCardTemp.h"
#import "FDJobModel.h"
#import "FDStudent.h"


@interface FDDiscoverController ()

@end

@implementation FDDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupViews];
    
    [self updateDiscoverData];
}

- (void)setupViews
{
    self.title = self.navigationController.tabBarItem.title;

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}

/**
 *  刷新数据
 */
 - (void)refreshData
{
    [self updateDiscoverData];
    [self.refreshControl endRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


/**
 *  获取一下discover的数据
 */
- (void)updateDiscoverData
{
//    初始化获取一下discover的数据，目的就是调用一下fetchedResultsController的getter的方法
    [[self.fetchedResultsController sections] count];
}

/**
 *  懒加载
 */
- (NSArray *)myOrganizations
{
    if (!_myOrganizations) {
        _myOrganizations = [NSArray array];
    }
    
    return _myOrganizations;
}


#pragma mark - uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.myOrganizations.count;  //获取组织个数
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FDContactModel *model = self.myOrganizations[section];
    XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:model.jidStr shouldFetch:YES];;
    NSArray *array = vCard.jobs; // 从电子名片中可以获取知道这个人有多少个招聘信息
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    FDJobModel *jobModel = [self getJobModelAtIndexPath:indexPath];
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
    
    FDContactModel *contactModel = self.myOrganizations[indexPath.section];   //获取从联系人列表,获取联系人模型
    FDJobModel *jobModel = [self getJobModelAtIndexPath:indexPath]; // 获取工作模型数据
    
    FDJobInfoController *vc = [[FDJobInfoController alloc] init];
    vc.title = @"职位详情";
    vc.jobModel = jobModel; //传递数据
    vc.contactModel = contactModel; //联系人模型
    vc.hideBar = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
 *  获取工作模型
 */
- (FDJobModel *)getJobModelAtIndexPath:(NSIndexPath *)indexPath
{
    FDJobModel *jobModel = nil;
    //根据账号，获取好友Vcard
    FDContactModel *model = self.myOrganizations[indexPath.section];
    XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:model.jidStr shouldFetch:YES];
    NSData *data = vCard.jobs[indexPath.row]; // 取出一条数据
    //Card.jobs  使用这个字段作为招聘信息,保存的nsstring类型
    //转换成工作模型
    if (data.length) {
        jobModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return jobModel;
}




@end
