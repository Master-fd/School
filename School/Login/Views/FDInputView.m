//
//  FDInputView.m
//  School
//
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDInputView.h"

@interface FDInputView()
{
    //accountBgImg
    UIImageView *_accountBgImg;
    //accountImg
    UIImageView *_accountImg;
    //passwordBgImg
    UIImageView *_passwordBgImg;
    //passwordImg
    UIImageView *_passwordImg;
   
}

@end
@implementation FDInputView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];   //add 控件
        
        [self setupConstraint];  //设置约束
    }
    
    
    return self;
}


/**
 *  初始化views
 */
- (void)setupViews
{
    //accountBgImg
    _accountBgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_input_up"]];
    _accountBgImg.userInteractionEnabled = YES;
    [self addSubview:_accountBgImg];
    
    //accountImg
    _accountImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_username_select"]];
    _accountImg.userInteractionEnabled = YES;
    [_accountBgImg addSubview:_accountImg];

    //accountTxFeild
    self.accountTxFeild = [[UITextField alloc] init];
    [_accountBgImg addSubview:self.accountTxFeild];
    self.accountTxFeild.font = [UIFont systemFontOfSize:23];
    self.accountTxFeild.textColor = [UIColor whiteColor];
    self.accountTxFeild.placeholder = @"请输入账号";
    self.accountTxFeild.keyboardType = UIKeyboardTypeDefault;
    self.accountTxFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTxFeild.returnKeyType = UIReturnKeyJoin;
    
    //passwordBgImg
    _passwordBgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_input_down"]];
    [self addSubview:_passwordBgImg];
    _passwordBgImg.userInteractionEnabled = YES;
    
    //passwordImg
    _passwordImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password_select"]];
    _passwordImg.userInteractionEnabled = YES;
    [_passwordBgImg addSubview:_passwordImg];
    
    //passwordTxFeild
    self.passwordTxFeild = [[UITextField alloc] init];
    [_passwordBgImg addSubview:self.passwordTxFeild];
    self.passwordTxFeild.font = [UIFont systemFontOfSize:23];
    self.passwordTxFeild.textColor = [UIColor whiteColor];
    self.passwordTxFeild.placeholder = @"请输入密码";
    self.passwordTxFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTxFeild.keyboardType = UIKeyboardTypeDefault;
    self.passwordTxFeild.returnKeyType = UIReturnKeyJoin;
    self.passwordTxFeild.secureTextEntry = YES;
   
    
    //add 登录图标
    self.loginBtn = [[UIButton alloc] init];
    [self addSubview:self.loginBtn];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    UIImage *image = [UIImage imageNamed:@"UMS_shake__share_button"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 15, 10, 15) resizingMode:UIImageResizingModeStretch];
    [self.loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setupConstraint
{
    CGFloat leftMargin = 20;
    CGFloat topMargin = 20;
    CGFloat rightMargin = leftMargin;
    
    //accountBgImg
    [_accountBgImg autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topMargin];  //距离父控件左边
    [_accountBgImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:leftMargin];
    [_accountBgImg autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:rightMargin];
    [_accountBgImg autoSetDimension:ALDimensionHeight toSize:40];
    
    //accountImg

    [_accountImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];  //距离父控件左边
    [_accountImg autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_accountImg autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_accountImg autoSetDimension:ALDimensionWidth toSize:20];  //设置size
    
    //accountTxFeild
    [self.accountTxFeild autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_accountImg];  //水平同齐
    [self.accountTxFeild autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_accountImg withOffset:15];
    [self.accountTxFeild autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.accountTxFeild autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.accountTxFeild autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    
    
    //passwordBgImg
    [_passwordBgImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:topMargin];  //距离父控件左边
    [_passwordBgImg autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_accountBgImg withOffset:5];
    [_passwordBgImg autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:rightMargin];
    [_passwordBgImg autoSetDimension:ALDimensionHeight toSize:40];
    
    //passwordImg
    [_passwordImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];  //距离父控件左边
    [_passwordImg autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_passwordImg autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_passwordImg autoSetDimension:ALDimensionWidth toSize:20];  //设置size
    
    //passwordTxFeild
    [self.passwordTxFeild autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_passwordImg];  //水平同齐
    [self.passwordTxFeild autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_passwordImg withOffset:15];
    [self.passwordTxFeild autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.passwordTxFeild autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.passwordTxFeild autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    
    //add 登录图标
    [self.loginBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_passwordBgImg];
    [self.loginBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_passwordBgImg];
    [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_passwordBgImg withOffset:10];
    [self.loginBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_accountBgImg];

}

- (void)loginClick
{
    //退出第一响应者身份
    [self endEditing:YES];

    //验证账号和密码是否符合要求
    NSString *accountStr = self.accountTxFeild.text;
    NSString *passwordStr = self.passwordTxFeild.text;

    if ((accountStr.length >= 15) || (accountStr.length < 6)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"合法账号长度6-15个字符"];
        });

        [self.accountTxFeild becomeFirstResponder];
        return;
    }
    if (passwordStr.length >= 15 || (passwordStr.length < 6) ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"合法密码长度6-15个字符"];
        });
        [self.passwordTxFeild becomeFirstResponder];
        return;
    }

    //传递账户和密码
    if (self.loginBtnClickBlock) {
        self.loginBtnClickBlock(accountStr, passwordStr);
    }

}


@end
