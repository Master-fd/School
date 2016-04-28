//
//  FDEditNicknameController.m
//  School
//
//  Created by asus on 16/4/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditNicknameController.h"
#import "FDStudent.h"
#import "FDOrganization.h"
#import "XMPPvCardTemp.h"


@interface FDEditNicknameController(){
    UITextField *_nicknameTextFeild;
    
}

@end


@implementation FDEditNicknameController

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
    _nicknameTextFeild.placeholder = @"  请输入昵称";
    _nicknameTextFeild.clearButtonMode = UITextFieldViewModeAlways;
    _nicknameTextFeild.backgroundColor = [UIColor whiteColor];
    [_nicknameTextFeild becomeFirstResponder];
    
    [_nicknameTextFeild autoSetDimension:ALDimensionHeight toSize:44];
    [_nicknameTextFeild autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(80, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
}

- (void)setupNav
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveNickname)];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)saveNickname
{
    [_nicknameTextFeild resignFirstResponder];
    if (_nicknameTextFeild.text.length) {
        if (self.isOrganization) {
            //组织
            [FDOrganization shareFDOrganization].myVcard.nickname = _nicknameTextFeild.text;
            [[FDOrganization shareFDOrganization] updateMyvCard];
        } else if(self.isDepartment) {
            //部门名
            [FDOrganization shareFDOrganization].myVcard.familyName = _nicknameTextFeild.text;
            [[FDOrganization shareFDOrganization] updateMyvCard];
        } else {
            //学生
            [FDStudent shareFDStudent].myVcard.nickname = _nicknameTextFeild.text;
            [[FDStudent shareFDStudent] updateMyvCard];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"不能为空"];
        });
        [_nicknameTextFeild becomeFirstResponder];
    }
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _nicknameTextFeild.placeholder = placeholder;
    
}
- (void)backgroundDidTap
{
    [self.view endEditing:YES];
}
@end
