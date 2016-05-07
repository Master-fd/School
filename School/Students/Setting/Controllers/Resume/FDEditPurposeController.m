//
//  FDEditPurposeController.m
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditPurposeController.h"
#import "FDEditBaseInfoView.h"
#import "FDStudent.h"

@interface FDEditPurposeController (){
    
    //求职意向职位
    FDEditBaseInfoView *_purposeViewOne;
    
    //部门
    FDEditBaseInfoView *_department;
}


@end

@implementation FDEditPurposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
    
    [self setupNav];
}


- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _purposeViewOne = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_purposeViewOne];
    if ([FDStudent shareFDStudent].resume.jobPurposeOne.length) {  //
        _purposeViewOne.textField.text = [FDStudent shareFDStudent].resume.jobPurposeOne;
    } else {
        _purposeViewOne.textField.placeholder = @"职位意向";
    }
    
    _department = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_department];
    if ([FDStudent shareFDStudent].resume.department.length) {  //
        _department.textField.text = [FDStudent shareFDStudent].resume.department;
    } else {
        _department.textField.placeholder = @"求职部门";
    }
    
}

- (void)setupContraints
{
    [_purposeViewOne autoSetDimension:ALDimensionHeight toSize:40];
    [_purposeViewOne autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(70, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_department autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_purposeViewOne];
    [_department autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_purposeViewOne];
    [_department autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_purposeViewOne];
    [_department autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_purposeViewOne];
    
    
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
    [FDStudent shareFDStudent].resume.jobPurposeOne = _purposeViewOne.textField.text;
    [FDStudent shareFDStudent].resume.department = _department.textField.text;
    
    [[FDStudent shareFDStudent] saveResume];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
