//
//  FDEditSpecialtyController.m
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditSpecialtyController.h"
#import "FDEditBaseInfoView.h"
#import "FDStudent.h"

@interface FDEditSpecialtyController (){

    //特长1
    FDEditBaseInfoView *_specialtyViewOne;
    
    //特长2
    FDEditBaseInfoView *_specialtyViewTwo;
}
    

@end

@implementation FDEditSpecialtyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
    
    [self setupNav];
}


- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];

    _specialtyViewOne = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_specialtyViewOne];
    if ([FDStudent shareFDStudent].resume.specialtyOne.length) {  //
        _specialtyViewOne.textField.text = [FDStudent shareFDStudent].resume.specialtyOne;
    } else {
        _specialtyViewOne.textField.placeholder = @"特长1";
    }

    _specialtyViewTwo = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_specialtyViewTwo];
    if ([FDStudent shareFDStudent].resume.specialtyTwo.length) {  //
        _specialtyViewTwo.textField.text = [FDStudent shareFDStudent].resume.specialtyTwo;
    } else {
        _specialtyViewTwo.textField.placeholder = @"特长2";
    }
    
}

- (void)setupContraints
{
    [_specialtyViewOne autoSetDimension:ALDimensionHeight toSize:40];
    [_specialtyViewOne autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(70, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_specialtyViewTwo autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_specialtyViewOne];
    [_specialtyViewTwo autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_specialtyViewOne];
    [_specialtyViewTwo autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_specialtyViewOne];
    [_specialtyViewTwo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_specialtyViewOne];
    

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
    [FDStudent shareFDStudent].resume.specialtyOne = _specialtyViewOne.textField.text;
    [FDStudent shareFDStudent].resume.specialtyTwo = _specialtyViewTwo.textField.text;
    [[FDStudent shareFDStudent] saveResume];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
