//
//  FDEditJobController.m
//  School
//
//  Created by asus on 16/4/27.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditJobController.h"
#import "FDOrganization.h"
#import "FDEditJobInfoView.h"
#import "FDEditJobDescriberView.h"
#import "FDJobModel.h"




@interface FDEditJobController (){
    UIView *_BgView;
    
    FDEditJobInfoView *_EditJobInfoView;
    
    FDEditJobDescriberView *_EditJobDescriberView;
    
    NSLayoutConstraint *_bottomConstraint;
    
}

@end

@implementation FDEditJobController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
    
    [self setupContraints];
}

- (void)setupNav
{
    self.title = @"发布职位";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(ReleaseOneJob)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = self.navigationController.tabBarItem.title;
}

- (void)setupViews
{
    //添加手势，退出键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReturnKeyboard)];
    [self.view addGestureRecognizer:tapGesture];
    
    _BgView = [[UIView alloc] init];
    [self.view addSubview:_BgView];
    self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    _EditJobInfoView = [[FDEditJobInfoView alloc] init];
    [_BgView addSubview:_EditJobInfoView];
    
    _EditJobDescriberView = [[FDEditJobDescriberView alloc] init];
    [_BgView addSubview:_EditJobDescriberView];
    
    //注册监听键盘,移动view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupContraints
{
    _BgView.frame = self.view.frame;
    
    [_EditJobInfoView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0) excludingEdge:ALEdgeBottom];
    
    [_EditJobDescriberView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_EditJobInfoView withOffset:10];
    [_EditJobDescriberView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_EditJobDescriberView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_EditJobDescriberView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
}

#pragma mark - 公共方法


/**
 *  发布一个职位
 */
- (void)ReleaseOneJob
{
    FDJobModel *model = [[FDJobModel alloc] init];
    
    model.jobCount = _EditJobInfoView.countTextField.text;
    model.jobHarvest = _EditJobInfoView.jobHarvesTextView.text;
    model.jobName = _EditJobInfoView.jobNameTextField.text;
    model.jobDescribe = _EditJobDescriberView.jobDescribe.text;
    model.icon = [FDOrganization shareFDOrganization].photo;
    model.organization = [FDOrganization shareFDOrganization].nickname;
    model.department = _EditJobInfoView.departmentLab.text;
    
    if (model.jobCount.length && model.jobHarvest.length
        && model.jobName.length && model.jobDescribe.length
        && model.organization.length && model.department.length
        && model.icon.length) {
        
        for (FDJobModel *mod in [FDOrganization shareFDOrganization].jobs) {
            if ([mod.jobName isEqualToString:model.jobName]
                && [mod.department isEqualToString:model.department]
                && [mod.organization isEqualToString:model.organization]) {

                dispatch_async(dispatch_get_main_queue(), ^{
                    [FDMBProgressHUB showSuccess:@"不能重复发布职位"];
                });
                return;
            }
        }
        
        //全部不为空，而且不能重复,才可以发布职位
        [[FDOrganization shareFDOrganization] addJobToMyVcard:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showSuccess:@"发布成功"];
        });
        //返回discover界面
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (!model.jobCount.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"职位数量不能为空"];
            });
            return;
        }
        if (!model.jobHarvest.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"职位诱惑不能为空"];
            });
            return;
        }
        if (!model.jobName.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"职位名称不能为空"];
            });
            return;
        }
        if (!model.jobDescribe.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"职位描述不能为空"];
            });
            return;
        }
        if (!model.icon.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"请先在设置中设置头像"];
            });
            return;
        }
        if (!model.organization.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"请先在设置中设置组织"];
            });
            return;
        }
        if (!model.department.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"请先在设置中设置部门"];
            });
            return;
        }
    }
}

/**
 *  退出键盘
 */
- (void)tapReturnKeyboard
{
    [self.view endEditing:YES];
}

/**
 *  添加键盘监听，伴随键盘移动
 */
- (void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *notificationInfo = [notification userInfo];
    
    NSTimeInterval duration;
    UIViewAnimationCurve *curve;
    CGRect keyboardFrame;
    
    [[notificationInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&duration];
    [[notificationInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&curve];
    [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    if ([_EditJobDescriberView.jobDescribe isFirstResponder]) {
        
    [UIView animateWithDuration:duration animations:^{
        //修改inputbar距离父控件的距离
        if ((notification.name == UIKeyboardWillShowNotification) && (_BgView.y > -100)) {
            _BgView.y -= keyboardFrame.size.height;
        }
        if ((notification.name == UIKeyboardWillHideNotification) && (_BgView.y < -100)) {
            _BgView.y = 0;
        }
    }];
    }
    
}

@end
