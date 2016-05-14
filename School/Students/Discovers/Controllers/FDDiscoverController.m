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

@property (nonatomic, strong) NSMutableArray *dataSource;   //保存在显示在屏幕上的联系人模型
@property (nonatomic, assign) int start;
@end

@implementation FDDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupViews];
    
    
}

- (void)setupViews
{
    self.title = self.navigationController.tabBarItem.title;

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateDiscoverData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
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
//    初始化获取一下discover的数据，目的就是调用一下fetchedResultsController的getter的方法,获取所有的组织好友
    [[self.fetchedResultsController sections] count];
    [self loadMoreData];
}

/**
 *  懒加载,里面保存的是自己关注的所有组织的contactmodel模型
 */
- (NSArray *)myOrganizations
{
    if (!_myOrganizations) {
        _myOrganizations = [NSArray array];
    }
    
    return _myOrganizations;
}
/**
 *  保存着显示在屏幕上的联系人模型
 */
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

/**
 *  加载更多数据
 */
- (void)loadMoreData
{
    NSUInteger numOfJobs = 0;
    int end = 0;
    NSMutableArray *arrayM = [NSMutableArray array];
    for (FDContactModel *model in self.myOrganizations) { //遍历保存每个组织有多少个职位
        XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:model.jidStr shouldFetch:YES];
        [arrayM addObject:[NSNumber numberWithUnsignedInteger:vCard.jobs.count]];
    }
    
    for (int i=self.start; i<arrayM.count; i++) {  //根据每个组织发布职位的情况，确定一次最大可以读取多少个组织的职位信息
        NSNumber *number = arrayM[i];        //读取太多了，占内存大，这里设置最大一次显示读取15个职位信息
        numOfJobs += [number unsignedIntegerValue]; //记录待显示的数据
        end = i+1;
        if (numOfJobs >= 20) {
            break;
        }
    }
    
    for (int j=self.start; j<end; j++) {  //继续添加保存需要显示的联系人模型
        FDContactModel *model = self.myOrganizations[j];
        [self.dataSource insertObject:model atIndex:0];
    }
    
    if (end>self.start) {
        self.start = end;
    }
    
}
//控制器被销毁
- (void)dealloc
{
    self.start = 0;
}



#pragma mark - uitableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FDDiscoverCell height];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;  //获取组织个数,每个组织一组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FDContactModel *contactModel = self.dataSource[section];   //获取从联系人列表,获取联系人模型
    XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:contactModel.jidStr shouldFetch:YES];
    return vCard.jobs.count;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDContactModel *contactModel = self.dataSource[indexPath.section];   //获取从联系人列表,获取联系人模型
    XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:contactModel.jidStr shouldFetch:YES];
    FDJobModel *jobModel = [NSKeyedUnarchiver unarchiveObjectWithData:vCard.jobs[indexPath.row]];
    
    FDJobInfoController *vc = [[FDJobInfoController alloc] init];
    vc.title = @"职位详情";
    vc.jobModel = jobModel; //传递数据
    vc.contactModel = contactModel; //联系人模型
    vc.hideBar = NO;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 公共方法

/**
 *  获取工作模型
 */
- (FDJobModel *)getJobModelAtIndexPath:(NSIndexPath *)indexPath
{
    FDJobModel *jobModel = nil;
    //根据账号，获取好友Vcard
    FDContactModel *model = self.dataSource[indexPath.section];
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
