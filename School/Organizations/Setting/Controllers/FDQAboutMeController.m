//
//  FDQAboutMeController.m
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQAboutMeController.h"
#import "FDOrganization.h"
#import "FDSettingCell.h"
#import "FDQEditPhotoController.h"
#import "FDEditNicknameController.h"
#import "FDQMyQRcodeController.h"
@interface FDQAboutMeController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation FDQAboutMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    self.tableView.backgroundColor = kBaseViewControlBackColor;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //刷新一下tabbleview
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger row = 0;
    
    if (section == 0) {
        row = 1;
    }else if (section == 1){
        row = 3;
    }else if (section == 2){
        row = 1;
    }
    
    return row;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FDSettingCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [[FDSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellPhoto"];
        if ([FDOrganization shareFDOrganization].photo.length) {
            cell.iconView.image = [UIImage imageWithData:[FDOrganization shareFDOrganization].photo];
            
        }else{
            cell.iconView.image = [UIImage imageNamed:@"user_avatar_default"];;
        }
        cell.titleLab.alpha = 0.8;
        cell.titleLab.text = @"头像";
        cell.iconView.hidden = NO;
    }else if (indexPath.section == 1){
        cell = [[FDSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellNickname"];
        cell.titleLab.alpha = 0.8;
        cell.iconView.hidden = YES;
        if (indexPath.row == 0) {
            cell.titleLab.text = @"账号";
            cell.detailTextLabel.text = [FDOrganization shareFDOrganization].account;
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"组织";
            if ([FDOrganization shareFDOrganization].nickname.length) {
                cell.detailTextLabel.text = [FDOrganization shareFDOrganization].nickname;
            } else {
                cell.detailTextLabel.text = @"请输入";
            }
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"部门";
            if ([FDOrganization shareFDOrganization].department.length) {
                cell.detailTextLabel.text = [FDOrganization shareFDOrganization].department;
            } else {
                cell.detailTextLabel.text = @"请输入";
            }
        }
        
    }else if (indexPath.section == 2){
        cell = (FDSettingCell *)[[FDSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QRCode"];
        cell.iconView.hidden = NO;
        cell.iconView.image = [UIImage imageNamed:@"setting_myQR"];
        cell.titleLab.text = @"二维码";
        cell.titleLab.alpha = 0.8;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        FDQEditPhotoController *photoVc = [[FDQEditPhotoController alloc] init];
        [self.navigationController pushViewController:photoVc animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 1) {
            //编辑组织名
            FDEditNicknameController *nicknameVc = [[FDEditNicknameController alloc] init];
            nicknameVc.title = @"编辑组织名";
            nicknameVc.placeholder = @"   请输入组织名";
            nicknameVc.organization = YES;
            nicknameVc.department = NO;
            [self.navigationController pushViewController:nicknameVc animated:YES];
        }else if (indexPath.row == 2) {
            //编辑部门名
            FDEditNicknameController *nicknameVc = [[FDEditNicknameController alloc] init];
            nicknameVc.title = @"编辑部门名";
            nicknameVc.placeholder = @"   请输入部门名";
            nicknameVc.organization = NO;
            nicknameVc.department = YES;
            [self.navigationController pushViewController:nicknameVc animated:YES];
        }
    }else if (indexPath.section == 2){
        //增加生成自己的二维码
        FDQMyQRcodeController *vc = [[FDQMyQRcodeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 19;
}

@end
