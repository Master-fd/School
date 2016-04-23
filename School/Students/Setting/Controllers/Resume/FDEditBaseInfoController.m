//
//  FDEditBaseInfoController.m
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditBaseInfoController.h"
#import "FDEditBaseInfoView.h"
#import "FDStudent.h"

@interface FDEditBaseInfoController (){
    //name
    FDEditBaseInfoView *_nameView;
    
    //专业
    FDEditBaseInfoView *_majorView;
    
    //电话
    FDEditBaseInfoView *_phoneNumberView;
    
    //邮箱
    FDEditBaseInfoView *_emailView;
    
}

@end

@implementation FDEditBaseInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
    
    [self setupNav];
}


- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    //name
    _nameView = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_nameView];
    if ([FDStudent shareFDStudent].resume.name.length) {  //姓名
        _nameView.textField.text = [FDStudent shareFDStudent].resume.name;
    } else {
        _nameView.textField.placeholder = @"姓名";
    }
    //专业
    _majorView = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_majorView];
    if ([FDStudent shareFDStudent].resume.major.length) {  //
        _majorView.textField.text = [FDStudent shareFDStudent].resume.major;
    } else {
        _majorView.textField.placeholder = @"专业";
    }
    
    //电话
    _phoneNumberView = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_phoneNumberView];
    if ([FDStudent shareFDStudent].resume.phoneNumber.length) {  //
        _phoneNumberView.textField.text = [FDStudent shareFDStudent].resume.phoneNumber;
    } else {
        _phoneNumberView.textField.placeholder = @"电话";
    }
    
    //邮箱
    _emailView = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_emailView];
    if ([FDStudent shareFDStudent].resume.Email.length) {  //
        _emailView.textField.text = [FDStudent shareFDStudent].resume.Email;
    } else {
        _emailView.textField.placeholder = @"邮箱";
    }
    
}

- (void)setupContraints
{
    [_nameView autoSetDimension:ALDimensionHeight toSize:40];
    [_nameView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(70, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_majorView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_nameView];
    [_majorView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameView];
    [_majorView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_nameView];
    [_majorView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameView];
    
    [_phoneNumberView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_majorView];
    [_phoneNumberView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_majorView];
    [_phoneNumberView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_majorView];
    [_phoneNumberView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_majorView];
    
    [_emailView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_phoneNumberView];
    [_emailView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_phoneNumberView];
    [_emailView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_phoneNumberView];
    [_emailView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneNumberView];
}
- (void)setupNav
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBaseInfoClick)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - 公共方法
- (void)saveBaseInfoClick
{
    //保存到简历
    [FDStudent shareFDStudent].resume.name = _nameView.textField.text;
    [FDStudent shareFDStudent].resume.major = _majorView.textField.text;
    [FDStudent shareFDStudent].resume.phoneNumber = _phoneNumberView.textField.text;
    [FDStudent shareFDStudent].resume.Email = _emailView.textField.text;
    [[FDStudent shareFDStudent] saveResume];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 懒加载

@end
