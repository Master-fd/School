//
//  FDResumeController.m
//  School
//
//  Created by asus on 16/4/18.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeController.h"
#import "FDStudent.h"
#import "FDResumePhotoCell.h"
#import "FDResumePurposeCell.h"
#import "FDResumeExperienceCell.h"
#import "FDResumeSpecialtyCell.h"
#import "FDResumeBaseInfoCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UIImage+FDExtension.h"
#import "FDEditBaseInfoController.h"
#import "FDEditExperienceController.h"
#import "FDEditSpecialtyController.h"
#import "FDEditPurposeController.h"


@interface FDResumeController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    
}

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation FDResumeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
}


- (void)setupViews
{
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];  //一定要刷新一下数据，否则更改之后可能无法及时显示出来
    });
    
}
#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 1;
    
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {  //简历头像
        FDResumePhotoCell *cell = [FDResumePhotoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([FDStudent shareFDStudent].resume.photo.length) {
            [cell.photoBtn setBackgroundImage:[UIImage imageWithData:[FDStudent shareFDStudent].resume.photo] forState:UIControlStateNormal];  //显示图片
        }
        
        __weak typeof(self) _weakself = self;
        cell.photoBlock = ^(UIButton *btn){  //在block中修改打开相册，读取照片，并显示到btn中
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = _weakself;
            [_weakself.navigationController presentViewController:imagePicker animated:YES completion:nil];
        };
        
        return cell;
    }else if (indexPath.section == 1){//简历  基本细信息
        FDResumeBaseInfoCell *cell = [FDResumeBaseInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.text = [FDStudent shareFDStudent].resume.name;
        cell.major.text = [FDStudent shareFDStudent].resume.major;
        cell.phoneNumber.text = [FDStudent shareFDStudent].resume.phoneNumber;
        cell.email.text = [FDStudent shareFDStudent].resume.Email;
        cell.editEnable = YES;
        __weak typeof(self) _weakself = self;
        cell.infoBlock = ^{
            FDEditBaseInfoController *vc = [[FDEditBaseInfoController alloc] init];
            vc.title = @"基本信息";
            [_weakself.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }else if (indexPath.section == 2){//经验
        FDResumeExperienceCell *cell = [FDResumeExperienceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.jobTitle.text = [FDStudent shareFDStudent].resume.jobTitle;
        cell.jobContent.text = [FDStudent shareFDStudent].resume.jobContent;
        cell.editEnable = YES;
        __weak typeof(self) _weakself = self;
        cell.infoBlock = ^{
            FDEditExperienceController *vc = [[FDEditExperienceController alloc] init];
            vc.title = @"工作经历";
            [_weakself.navigationController pushViewController:vc animated:YES];
        };

        return cell;
    }else
    if (indexPath.section == 3){//特长
        FDResumeSpecialtyCell *cell = [FDResumeSpecialtyCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.specialtyOne.text = [FDStudent shareFDStudent].resume.specialtyOne;
        cell.specialtyTwo.text = [FDStudent shareFDStudent].resume.specialtyTwo;
        cell.editEnable = YES;
        __weak typeof(self) _weakself = self;
        cell.infoBlock = ^{
            FDEditSpecialtyController *vc = [[FDEditSpecialtyController alloc] init];
            vc.title = @"特长";
            [_weakself.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }else if (indexPath.section == 4){//求职意向
        FDResumePurposeCell *cell = [FDResumePurposeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editEnable = YES;
        cell.purposeOne.text = [FDStudent shareFDStudent].resume.jobPurposeOne;
        cell.department.text = [FDStudent shareFDStudent].resume.department;
        __weak typeof(self) _weakself = self;
        cell.infoBlock = ^{
            FDEditPurposeController *vc = [[FDEditPurposeController alloc] init];
            vc.title = @"求职意向";
            [_weakself.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = [FDResumePhotoCell height];
    }else if (indexPath.section == 1){
        height = [FDResumeBaseInfoCell height];
    }else if (indexPath.section == 2){
        height = [FDResumeExperienceCell height];
    }else if (indexPath.section == 3){
        height = [FDResumeSpecialtyCell height];
    }else if (indexPath.section == 4){
        height = [FDResumePurposeCell height];
    }
    
    return height;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    if (section == 0) {
        title = @"添加头像";
    }else if (section == 1){
        title = @"基本信息";
    }else if (section == 2){
        title = @"工作经验";
    }else if (section == 3){
        title = @"特长";
    }else if (section == 4){
        title = @"求职意向";
    }
    
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIImagePickerController delegate
//resume 添加图片呢
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    image = [image imageWithSize:CGSizeMake(140, 140)];  //裁剪图片
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [FDStudent shareFDStudent].resume.photo = UIImagePNGRepresentation(image);
        [[FDStudent shareFDStudent] saveResume];// 保存resume
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}


@end
