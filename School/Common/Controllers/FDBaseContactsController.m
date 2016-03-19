//
//  FDContactsViewController.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseContactsController.h"
#import "FDContactViewCell.h"
#import "FDGroupModel.h"
#import "FDContactModel.h"
#import "FDContactHeaderViewCell.h"



@interface FDBaseContactsController ()<FDContactHeaderViewCellDelegate>



@end

@implementation FDBaseContactsController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionFooterHeight = 1;   //section之间距离
}


/**
 *  懒加载
 */
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
        
        for (int i=0; i<10; i++) {
            FDGroupModel *model = [[FDGroupModel alloc] init];
            model.groupName = [NSString stringWithFormat:@"sada%d", i];
            model.onlineCount = 1;
            model.contactCount = 8;
            [_groups addObject:model];
        }
    }
    
    return _groups;
}


#pragma mark - Table view data source
//返回组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    FDGroupModel *groupModel = self.groups[section];
    if (groupModel.isVisible) {
        return groupModel.contacts.count;
    }else{
        return 0;
    }
}

//设置cell数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取数据
    FDGroupModel *groupModel = self.groups[indexPath.section];
    FDContactModel *contactModel = groupModel.contacts[indexPath.row];
    
    FDContactViewCell *cell = [FDContactViewCell contactViewCellWithTableView:tableView];
    
    //设置数据
    cell.contactModel = contactModel;
    return cell;
}

//自动计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


//返回分组名称,不要返回uiview，需要返回UITableViewHeaderFooterView才可以重用
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //获取数据
    FDGroupModel *groupModel = self.groups[section];
    
    //新建cell
    FDContactHeaderViewCell *cell = [FDContactHeaderViewCell contactHeaderViewCellWithTableView:tableView];
    
    //设置tag，记录当前是第几分组
    cell.tag = section;
    
    //设置数据
    cell.groupModel = groupModel;
    
    //设置代理
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - FDContactHeaderViewCellDelegate
//分组被点击，
- (void)groupHeaderViewDidClickButton:(FDContactHeaderViewCell *)groupHeaderViewCell
{
    
    //刷新tableview,只刷新这个分组
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:groupHeaderViewCell.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}
@end



