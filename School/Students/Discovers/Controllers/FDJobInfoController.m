//
//  FDJobInfoController.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDJobInfoController.h"
#import "FDJobButtonView.h"
#import "FDJobDescribeViewCell.h"
#import "FDJobInfoViewCell.h"
#import "FDJobButtonView.h"
#import "FDChatController.h"
#import "FDContactModel.h"

@interface FDJobInfoController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FDJobButtonView *jobButtonView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FDJobInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _jobButtonView = [[FDJobButtonView alloc] init];
    [self.view addSubview:_jobButtonView];
    __weak typeof(self) _weakself = self;
    _jobButtonView.sendResumeToXmppJidStrBlock = ^{
        //发送简历
        FDChatController *vc = [[FDChatController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = _weakself.contactModel.nickname;
        vc.jidStr = _weakself.contactModel.jidStr;
        FDLog(@"send resume to %@", _weakself.contactModel.jidStr);
    };
    _jobButtonView.sendMessageToXmppJidStrBlock = ^{
        //push到聊天界面
        FDChatController *vc = [[FDChatController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = _weakself.contactModel.nickname;
        vc.jidStr = _weakself.contactModel.jidStr;
        [_weakself.navigationController pushViewController:vc animated:YES];
        
    };

}

- (void)setupContraints
{
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 50, 0)];
    
    [_jobButtonView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_jobButtonView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        FDJobInfoViewCell *cell = [FDJobInfoViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.jobModel;
        return cell;
    }else if (indexPath.section == 1){
        FDJobDescribeViewCell *cell = [FDJobDescribeViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置数据
        cell.model = self.jobModel;
        return cell;
    }
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [FDJobInfoViewCell height];
    }else if (indexPath.section == 1){
        return [FDJobDescribeViewCell height];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else if (section == 1) {
        return 0;
    }
    return 0;
}

    

@end
