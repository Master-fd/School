//
//  FDAddFriendViewController.m
//  School
//  添加朋友控制器，需要输入用户account，或者扫一扫
//  Created by asus on 16/4/15.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAddFriendViewController.h"

@interface FDAddFriendViewController ()<UISearchBarDelegate>{
    
    /**
     *  好友账号搜索框
     */
    UISearchBar *_searchBar;
    
    UIButton *_scanBgBtn;
    
    UIImageView *_scanImageView;
    
    UILabel *_titleLable;
    
    UILabel *_subTitleLable;
    
}


@end

@implementation FDAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
    
    [self setupContraints];
}


/**
 *  设置导航栏
 */
- (void)setupNav
{
    
    self.title = @"添加好友";
}

/**
 *  初始化view
 */
- (void)setupViews
{
    self.view.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingExitKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入好友账户";
    _searchBar.keyboardType = UIKeyboardTypeWebSearch;
    [self.view addSubview:_searchBar];
    
    _scanBgBtn = [[UIButton alloc] init];
    [_scanBgBtn setBackgroundColor:[UIColor whiteColor]];
    [_scanBgBtn addTarget:self action:@selector(scanQRCodeAddFriend) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_scanBgBtn];
    
    _scanImageView = [[UIImageView alloc] init];
    _scanImageView.image = [UIImage imageNamed:@"add_friend_icon_scanqr"];
    [_scanBgBtn addSubview:_scanImageView];
    
    _titleLable = [[UILabel alloc] init];
    _titleLable.text = @"扫一扫";
    _titleLable.font = [UIFont systemFontOfSize:16];
    _titleLable.alpha = 0.8;
    [_scanBgBtn addSubview:_titleLable];
    
    _subTitleLable = [[UILabel alloc] init];
    _subTitleLable.text = @"扫描二维码名片";
    _subTitleLable.font = [UIFont systemFontOfSize:12];
    _subTitleLable.alpha = 0.8;
    [_scanBgBtn addSubview:_subTitleLable];
    
    
}
/**
 *  add 约束
 */
- (void)setupContraints
{
    [_searchBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(75, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_searchBar autoSetDimension:ALDimensionHeight toSize:50];
    
    [_scanBgBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_searchBar];
    [_scanBgBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_searchBar];
    [_scanBgBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_searchBar withOffset:20];
    
    [_scanImageView autoSetDimensionsToSize:CGSizeMake(40, 40)];
    [_scanImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_scanImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    
    [_titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_scanImageView withOffset:8];
    [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_scanImageView];
    [_titleLable sizeToFit];
    
    [_subTitleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLable];
    [_subTitleLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_scanImageView];
    [_subTitleLable sizeToFit];

}
/**
 *  扫描二维码添加朋友
 */
- (void)scanQRCodeAddFriend
{
    [self.view endEditing:YES];
    
    FDTestViewController *vc = [[FDTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    FDLog(@"扫描二维码添加朋友");
}

/**
 *  单击背景，退出键盘
 */
- (void)endEditingExitKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - UISearchBar  delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
    
    if ((searchBar.text.length > 6) && (searchBar.text.length < 15)) {
        //不是数字或英文
        NSString *pattern = @"^[0-9a-zA-Z]+$";
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
            NSArray *results = [regex matchesInString:searchBar.text options:0 range:NSMakeRange(0, searchBar.text.length)];
            
            if (!results.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [FDMBProgressHUB showError:@"账户只能是数字或英文"];
                });
                [searchBar becomeFirstResponder];
                searchBar.text = @"";
                return;
            }
        
        //发送账户，添加好友
        [self addFriend:searchBar.text];
        
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
           [FDMBProgressHUB showError:@"合法账号长度6-15个字符"];
        });
        [searchBar becomeFirstResponder];
        searchBar.text = @"";
    }
    
    searchBar.text = @"";
}

/**
 *  联网添加好友
 */
- (void)addFriend:(NSString *)account
{
    //判断是否是添加自己
    if ([account isEqualToString:[FDUserInfo shareFDUserInfo].account]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"不能添加自己"];
        });
        
        return;
    }
    
    //判断好友是否存在
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@", account, ServerName];
    XMPPJID *friendJid = [XMPPJID jidWithString:jidStr];
    if ([[FDXMPPTool shareFDXMPPTool].rosterStorage userExistsWithJID:friendJid xmppStream:[FDXMPPTool shareFDXMPPTool].xmppStream]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"好友已存在"];
        });
        
        return;
    }
        
    //发送订阅请求，将nickname设置成默认account
    [[FDXMPPTool shareFDXMPPTool].roster addUser:friendJid withNickname:account];
}

@end
