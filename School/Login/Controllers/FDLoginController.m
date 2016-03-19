//
//  FDLoginController.m
//  School
//   登录和注册界面控制器
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDLoginController.h"
#import "FDBaseLoginController.h"
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
    __weak typeof(self) _weakSelf = self;
    _inputView.loginBtnClickBlock = ^(NSString *accountStr, NSString *passwordStr){
        [_weakSelf userLoginOrRegister:accountStr pwd:passwordStr];
    };
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
    [_inputView autoSetDimension:ALDimensionHeight toSize:260];
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
 *  登录 、 注册、下一步
 */
- (void)userLoginOrRegister:(NSString *)accountStr pwd:(NSString *)passwordStr
{
    if ([FDXMPPTool shareFDXMPPTool].isRegisterOperation) {
        //注册操作
        [FDUserInfo shareFDUserInfo].registerAccount = accountStr;
        [FDUserInfo shareFDUserInfo].registerPassword = passwordStr;
    }else{
        //登录操作  默认为no
        [FDUserInfo shareFDUserInfo].account = accountStr;
        [FDUserInfo shareFDUserInfo].password = passwordStr;
        //保存账户密码到沙盒
        [[FDUserInfo shareFDUserInfo] writeUserInfoToSabox];
    }
    
    //连接登录/注册
    [FDBaseLoginController UserConnetToHost];
}

- (void)registerClick
{
    //清空textfeild
    [_inputView clearAllTextFeild];
    
    [FDXMPPTool shareFDXMPPTool].registerOperation = ![FDXMPPTool shareFDXMPPTool].registerOperation;
    //_inputView.loginBtn.enabled = YES;
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
