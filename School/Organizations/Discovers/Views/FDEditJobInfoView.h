//
//  FDEditJobInfoCell.h
//  School
//
//  Created by asus on 16/4/27.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDEditJobInfoView : UIView

@property (nonatomic, strong) UITextField *jobNameTextField;   //工作名称

@property (nonatomic, strong) UITextField *countTextField;      //人数

@property (nonatomic, strong) UITextView *jobHarvesTextView; //职位诱惑编辑

@property (nonatomic, strong) UITextField *departmentLab;   //部门; //组织

+ (CGFloat)height;

@end
