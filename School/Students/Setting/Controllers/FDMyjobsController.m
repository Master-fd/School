//
//  FDMyjobsController.m
//  School
//
//  Created by asus on 16/4/18.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyjobsController.h"
#import "FDResumejobModel.h"
#import "FDJobInfoController.h"
#import "XMPPvCardTemp.h"
#import "FDJobModel.h"
#import "FDMyApplyInfoCell.h"


@interface FDMyjobsController ()

@property (nonatomic, strong) NSArray *dataSources;  //保存的子元素是FDResumejobModel

@end

@implementation FDMyjobsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

/**
 *  初始化views
 */
- (void)setupViews
{
    if (!self.dataSources.count) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"没有应聘信息"];
        });
        
        return;
    }
    
    self.tableView.rowHeight = 60;
}
/**
 *  懒加载
 */
- (NSArray *)dataSources
{
    if (!_dataSources) {
        //从plist里面加载所有已应聘工作数据
        NSArray *data = [NSArray arrayWithContentsOfFile:kMyApplyInfoPlistPath];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dic in data) {
            FDResumejobModel *model = [FDResumejobModel resumeJobWithDict:dic];
            [arrayM addObject:model];
        }
        _dataSources = arrayM;
    }
    
    return _dataSources;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellId = @"cellJobId";
    
    FDResumejobModel *model = self.dataSources[indexPath.row];
    //新建cell
    FDMyApplyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FDMyApplyInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    //设置数据
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    FDJobModel *jobModel = [self getJobModelAtIndexPath:indexPath]; // 获取工作模型数据
    FDJobInfoController *vc = [[FDJobInfoController alloc] init];
    vc.title = @"职位详情";
    vc.jobModel = jobModel; //传递数据
    vc.hideBar = YES;  //隐藏底部的发送简历bar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 公共方法
//根据jidstr,获取用户vcard，找到用户的jobs段，判断是否这个信息还有效，如果有效，则连接到招聘信息处
- (FDJobModel *)getJobModelAtIndexPath:(NSIndexPath *)indexPath
{
    FDJobModel *myJobModel = nil;
    FDResumejobModel *model = self.dataSources[indexPath.row];  //获取已应聘job模型
    
    //modeljidstr，获取好友Vcard
    XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:model.jidStr shouldFetch:YES];
    //遍历用户的所有发布的jobs，查看这条信息是否还存在
    if (vCard.jobs.count)
    {
        for (NSData *data in vCard.jobs) {
            //Card.jobs  使用这个字段作为招聘信息,保存的nsstring类型
            //转换成工作模型
            if (data.length) {
                FDJobModel *jobmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if ([model.jobName isEqualToString:jobmodel.jobName]) {
                    myJobModel = jobmodel;  //这条招聘信息还在
                    break;
                }
            }
        }
    }
    
    return myJobModel;
}
//删除jobinfo
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除一条数据
        [self deleteApplyInfoWithPlist:indexPath];
        //刷新tableview
        [self.tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 公共方法
/**
 *  删除一条应聘信息
 */
- (void)deleteApplyInfoWithPlist:(NSIndexPath *)indexPath
{
    //删除一条数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.dataSources];
    [arrayM removeObjectAtIndex:indexPath.row];
    self.dataSources = arrayM;
    //先读取数据
    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:kMyApplyInfoPlistPath];
    [data removeObjectAtIndex:indexPath.row];
    //重新写入
    [data writeToFile:kMyApplyInfoPlistPath atomically:YES];
}


@end
