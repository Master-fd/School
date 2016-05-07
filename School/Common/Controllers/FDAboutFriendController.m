//
//  FDAboutFriendController.m
//  School
//
//  Created by asus on 16/4/25.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAboutFriendController.h"
#import "FDAboutFriendCell.h"
#import "XMPPvCardTemp.h"
#import "FDEditBeizhuController.h"
#import "FDQMyQRCodeController.h"


@interface FDAboutFriendController ()

@property (nonatomic, strong) XMPPvCardTemp *vCard;

@end

@implementation FDAboutFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    self.tableView.backgroundColor = kBaseViewControlBackColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beizhuDidchange:) name:kEditBeizhuNotification object:nil];
}
/**
 *  收到通知的时候，马上修改对应的显示
 */
- (void)beizhuDidchange:(NSNotification *)notification
{
    NSString *name = [notification.userInfo objectForKey:kBeizhuNameKey];
    self.title = name;
    self.nickname = name;
}

/**
 *  一定要移除监听
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    FDAboutFriendCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [[FDAboutFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellPhoto"];
        if (self.vCard.photo.length) {
            cell.iconView.image = [UIImage imageWithData:self.vCard.photo];
            
        }else{
            cell.iconView.image = [UIImage imageNamed:@"user_avatar_default"];;
        }
        cell.titleLab.alpha = 0.8;
        cell.titleLab.text = @"头像";
        cell.iconView.hidden = NO;
    }else if (indexPath.section == 1){
        cell = [[FDAboutFriendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellNickname"];
        cell.titleLab.alpha = 0.8;
        cell.iconView.hidden = YES;
        if (indexPath.row == 0) {
            cell.titleLab.text = @"账号";
            cell.detailTextLabel.text = [self.jidStr substringWithRange:NSMakeRange(0, self.jidStr.length - ServerName.length - 1)];
        }else if (indexPath.row == 1){
            cell.titleLab.text = @"昵称";
            if (self.vCard.nickname.length) {
                cell.detailTextLabel.text = self.vCard.nickname;
            } else {
                cell.detailTextLabel.text = [self.jidStr substringWithRange:NSMakeRange(0, self.jidStr.length - ServerName.length - 1)];
            }
        }else if (indexPath.row == 2){
            cell = [[FDAboutFriendCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellbeizhu"];
            cell.titleLab.alpha = 0.8;
            cell.iconView.hidden = YES;
            cell.titleLab.text = @"备注";
            if (self.nickname.length) {
                cell.detailTextLabel.text = self.nickname;
            } else {
                cell.detailTextLabel.text = @"添加备注";
            }
        }
        
    }else if (indexPath.section == 2){
        cell = [[FDAboutFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QRCode"];
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
    
    if (indexPath.section == 1){
        if (indexPath.row == 2) {
            FDEditBeizhuController *vc = [[FDEditBeizhuController alloc] init];
            vc.jidStr = self.jidStr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        //查看好友二维码
        FDQMyQRcodeController *vc = [[FDQMyQRcodeController alloc] init];
        vc.jidStr = self.jidStr;
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

#pragma mark - 公共方法
- (void)setJidStr:(NSString *)jidStr
{
    _jidStr = jidStr;
    
}

- (XMPPvCardTemp *)vCard
{
    return [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:self.jidStr shouldFetch:YES];;
}

@end
