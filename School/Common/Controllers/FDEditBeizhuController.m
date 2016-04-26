//
//  FDEditBeizhuController.m
//  School
//
//  Created by asus on 16/4/25.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditBeizhuController.h"

@interface FDEditBeizhuController (){
    UITextField *_nicknameTextFeild;
}
@end

@implementation FDEditBeizhuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupViews
{
    UITapGestureRecognizer *tapGestureReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundDidTap)];
    [self.view addGestureRecognizer:tapGestureReg];
    
    _nicknameTextFeild = [[UITextField alloc] init];
    [self.view addSubview:_nicknameTextFeild];
    _nicknameTextFeild.placeholder = @"  请输入备注";
    _nicknameTextFeild.clearButtonMode = UITextFieldViewModeAlways;
    _nicknameTextFeild.backgroundColor = [UIColor whiteColor];
    [_nicknameTextFeild becomeFirstResponder];
    
    [_nicknameTextFeild autoSetDimension:ALDimensionHeight toSize:44];
    [_nicknameTextFeild autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(80, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
}

- (void)setupNav
{
    self.title = @"备注";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickname)];
    self.navigationItem.rightBarButtonItem = item;
}



- (void)saveNickname
{
    [_nicknameTextFeild resignFirstResponder];
    if (_nicknameTextFeild.text.length) {//设置用户备注
        [[FDXMPPTool shareFDXMPPTool] xmppUpdateNickname:_nicknameTextFeild.text forUserJidStr:self.jidStr];
        NSDictionary *userInfo = @{kBeizhuNameKey : _nicknameTextFeild.text};
        [[NSNotificationCenter defaultCenter] postNotificationName:kEditBeizhuNotification object:self userInfo:userInfo];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"请输入备注"];
        });
        [_nicknameTextFeild becomeFirstResponder];
    }
    
}

- (void)backgroundDidTap
{
    [self.view endEditing:YES];
}

- (void)setJidStr:(NSString *)jidStr
{
    _jidStr = jidStr;
}
@end
