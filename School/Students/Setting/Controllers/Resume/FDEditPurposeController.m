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
    
    //特长1
    FDEditBaseInfoView *_purposeViewOne;
    
    //特长2
    FDEditBaseInfoView *_purposeViewTwo;
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
        _purposeViewOne.textField.placeholder = @"职位意向1";
    }
    
    _purposeViewTwo = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_purposeViewTwo];
    if ([FDStudent shareFDStudent].resume.jobPurposeTwo.length) {  //
        _purposeViewTwo.textField.text = [FDStudent shareFDStudent].resume.jobPurposeTwo;
    } else {
        _purposeViewTwo.textField.placeholder = @"职位意向2";
    }
    
}

- (void)setupContraints
{
    [_purposeViewOne autoSetDimension:ALDimensionHeight toSize:40];
    [_purposeViewOne autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(70, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_purposeViewTwo autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_purposeViewOne];
    [_purposeViewTwo autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_purposeViewOne];
    [_purposeViewTwo autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_purposeViewOne];
    [_purposeViewTwo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_purposeViewOne];
    
    
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
    [FDStudent shareFDStudent].resume.jobPurposeTwo = _purposeViewTwo.textField.text;
    [[FDStudent shareFDStudent] saveResume];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
