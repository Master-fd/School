//
//  FDEditExperienceController.m
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditExperienceController.h"
#import "FDStudent.h"
#import "FDEditBaseInfoView.h"

@interface FDEditExperienceController ()<UITextViewDelegate>{
    
    //工作名称
    FDEditBaseInfoView *_jobTitleView;
    
    //工作内容
    UIView *_bgView;
    UIImageView *_icon;
    UITextField *_textField;

    //工作内容编辑
    UITextView *_jobContentTextView;
}

@end

@implementation FDEditExperienceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
    
    [self setupNav];
}


- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    //工作名称
    _jobTitleView = [[FDEditBaseInfoView alloc] init];
    [self.view addSubview:_jobTitleView];
    if ([FDStudent shareFDStudent].resume.jobTitle.length) {  //
        _jobTitleView.textField.text = [FDStudent shareFDStudent].resume.jobTitle;
    } else {
        _jobTitleView.textField.placeholder = @"职位名称";
    }
    //工作内容
    _bgView = [[UIView alloc] init];
    [self.view addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_edit_modify"]];
    [_bgView addSubview:_icon];
    
    _textField = [[UITextField alloc] init];
    [_bgView addSubview:_textField];
    _textField.placeholder = @"工作内容";
    _textField.userInteractionEnabled = NO;
    
    //工作内容编辑
    _jobContentTextView = [[UITextView alloc] init];
    [self.view addSubview:_jobContentTextView];
    _jobContentTextView.font = [UIFont systemFontOfSize:16];
    _jobContentTextView.keyboardType = UIKeyboardAppearanceDefault;
    _jobContentTextView.delegate = self;
    _jobContentTextView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    _jobContentTextView.layer.masksToBounds = YES;
    _jobContentTextView.layer.cornerRadius = 3;

}

- (void)setupContraints
{
    [_jobTitleView autoSetDimension:ALDimensionHeight toSize:40];
    [_jobTitleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(70, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_bgView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_jobTitleView];
    [_bgView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobTitleView];
    [_bgView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_jobTitleView];
    [_bgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobTitleView];
    
    [_icon autoSetDimensionsToSize:CGSizeMake(20, 20)];
    [_icon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
    [_textField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_icon withOffset:15];
    [_textField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_textField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_icon];
    [_textField autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_icon];
    
    [_jobContentTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bgView];
    [_jobContentTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_bgView withOffset:15];
    [_jobContentTextView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_bgView withOffset:-15];
    [_jobContentTextView autoSetDimension:ALDimensionHeight toSize:70];
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
    [FDStudent shareFDStudent].resume.jobTitle = _jobTitleView.textField.text;
    [FDStudent shareFDStudent].resume.jobContent = _jobContentTextView.text;
    [[FDStudent shareFDStudent] saveResume];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - uitextviewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [_jobContentTextView resignFirstResponder];
        
        return NO;
    }
    if (_jobContentTextView.text.length > 120) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"长度不能超过120个字"];
        });
        return NO;
    }
    return YES;
}



@end
