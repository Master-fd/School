//
//  FDLoginController.m
//  School
//
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDLoginController.h"
#import "FDInputView.h"


@interface FDLoginController ()
{

    UIImageView *_bgImg;  //背景

    FDInputView *_inputView;   //inputview

    UIButton *_registerBtn;    //注册
    
}

@end

@implementation FDLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    [self setupViews]; //初始化控件
    [self setupContraint];
    [self displayUser];  //显示用户账户和密码
    
}

- (void)setupViews
{
    //设置导航栏标题
    [self.navigationItem setTitle:@"欢迎"];
    
    //add  背景
    _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome_0"]];
    [self.view addSubview:_bgImg];
    _bgImg.alpha = 0.7;
    _bgImg.userInteractionEnabled = YES;
    
    //add 输入框view
    _inputView = [[FDInputView alloc] init];
    [_bgImg addSubview:_inputView];
    
    //add registerBtn
    _registerBtn = [[UIButton alloc] init];
    [_bgImg addSubview:_registerBtn];
    _registerBtn.tintColor = [UIColor whiteColor];
    [_registerBtn setTitle:@"马上注册" forState:UIControlStateNormal];
    
    
    //设置单击事件
    [_inputView.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];

}

/**
 *  添加约束
 */
- (void)setupContraint
{
    //_bgImg
    [_bgImg autoSetDimensionsToSize:[UIScreen mainScreen].bounds.size];
    [_bgImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_bgImg autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    
    //inputView
    [_inputView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [_inputView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [_inputView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:70];
    [_inputView autoSetDimension:ALDimensionHeight toSize:200];
    [_inputView inputView];
    
    //registerBtn
    [_registerBtn autoAlignAxis:ALAxisVertical toSameAxisOfView:_inputView];
    [_registerBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_inputView withOffset:50];
    [_registerBtn sizeToFit];
    
}

/**
 *  显示用户信息
 */
- (void)displayUser
{
    _inputView.accountTxFeild.text = [FDUserInfo shareFDUserInfo].account;
    _inputView.passwordTxFeild.text = [FDUserInfo shareFDUserInfo].password;
}

/**
 *  用户登录
 */
- (void)userLogin
{
    //联网登录
    dispatch_async(dispatch_get_main_queue(), ^{
       // [FDMBProgressHUB showMessage:@"正在登录..."];
    });
}
/**
 *  用户注册
 */
- (void)userRegister
{
    dispatch_async(dispatch_get_main_queue(), ^{
     //   [FDMBProgressHUB showMessage:@"正在联网..."];
    });
}
/**
 *  登录 、 注册
 */
- (void)loginClick
{
    //退出第一响应者身份
    [self.view endEditing:YES];
    
    //验证账号和密码是否符合要求
    NSString *accountStr = _inputView.accountTxFeild.text;
    NSString *passwordStr = _inputView.passwordTxFeild.text;
    
    if ((accountStr.length >= 15) || (accountStr.length < 6)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"合法账号长度6-15个字符"];
        });
        
        [_inputView.accountTxFeild becomeFirstResponder];
        return;
    }
    if (passwordStr.length >= 15 || (passwordStr.length < 6) ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"合法密码长度6-15个字符"];
        });
        [_inputView.passwordTxFeild becomeFirstResponder];
        return;
    }
    
    //保存账户密码到沙盒
    [FDUserInfo shareFDUserInfo].account = accountStr;
    [FDUserInfo shareFDUserInfo].password = passwordStr;
    [[FDUserInfo shareFDUserInfo] writeUserInfoToSabox];

    if ([FDXMPPTool shareFDXMPPTool].isRegisterOperation) {
        //注册操作
        [self userRegister];
    }else{
        //登录操作  默认为no
        [self userLogin];
    }
}

- (void)registerClick
{
    [FDXMPPTool shareFDXMPPTool].registerOperation = ![FDXMPPTool shareFDXMPPTool].registerOperation;
    
    if ([FDXMPPTool shareFDXMPPTool].isRegisterOperation) {
        [_inputView.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    }else{
        [_inputView.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_registerBtn setTitle:@"马上注册" forState:UIControlStateNormal];
    }
    //使accountTxFeild成为第一响应者
    [_inputView.accountTxFeild becomeFirstResponder];
}

#pragma mark - Navigation
/**
 *  即将跳转到下一个界面
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
}



@end
