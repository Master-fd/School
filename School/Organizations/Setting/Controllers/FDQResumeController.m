//
//  FDQResumeController.m
//  School
//
//  Created by asus on 16/4/29.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQResumeController.h"
#import "FDStudent.h"
#import "FDResumePhotoCell.h"
#import "FDResumePurposeCell.h"
#import "FDResumeExperienceCell.h"
#import "FDResumeSpecialtyCell.h"
#import "FDResumeBaseInfoCell.h"
#import "NSObject+CoreDataHelper.h"
#import "FDQResume+FDCoreDataProperties.h"
#import "FDJobButtonView.h"
#import "FDChatController.h"
#import "FDChatModel.h"

@interface FDQResumeController ()<UITableViewDataSource, UITableViewDelegate>{
    
    UIButton *_rightBarBtn;
    
    
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FDQResumeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupViews];
    
}

- (void)setupNav
{
    _rightBarBtn = [[UIButton alloc] init];
    _rightBarBtn.frame = CGRectMake(0, 0, 23, 23);
    [_rightBarBtn setBackgroundImage:[UIImage imageNamed:@"icon_star_normal"] forState:UIControlStateNormal];
    [_rightBarBtn setBackgroundImage:[UIImage imageNamed:@"icon_star_select"] forState:UIControlStateSelected];
    [_rightBarBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)setupViews
{
    [self.view addSubview:self.tableView];
    
 
    
}

- (void)setupContraints
{
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
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


#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {  //简历头像
        FDResumePhotoCell *cell = [FDResumePhotoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editEnable = NO;
        if (self.model.photo.length) {
            [cell.photoBtn setBackgroundImage:[UIImage imageWithData:self.model.photo] forState:UIControlStateNormal];  //显示图片
        }
        return cell;
        
    }else if (indexPath.section == 1){//简历  基本细信息
        FDResumeBaseInfoCell *cell = [FDResumeBaseInfoCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.text = self.model.name;
        cell.major.text = self.model.major;
        cell.phoneNumber.text = self.model.phoneNumber;
        cell.email.text = self.model.email;
        cell.editEnable = NO;
        return cell;
    }else if (indexPath.section == 2){//经验
        FDResumeExperienceCell *cell = [FDResumeExperienceCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.jobTitle.text = self.model.jobTitle;
        cell.jobContent.text = self.model.jobContent;
        cell.editEnable = NO;
        return cell;
    }else if (indexPath.section == 3){//特长
        FDResumeSpecialtyCell *cell = [FDResumeSpecialtyCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.specialtyOne.text = self.model.specialtyOne;
        cell.specialtyTwo.text = self.model.specialtyTwo;
        cell.editEnable = NO;
        
        return cell;
    }else if (indexPath.section == 4){//求职意向
        FDResumePurposeCell *cell = [FDResumePurposeCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editEnable = NO;
        cell.purposeOne.text = self.model.jobPurposeOne;
        cell.purposeTwo.text = self.model.jobPurposeTwo;
        
        
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

#pragma mark 公共方法
/**
 *  添加到收藏夹
 */
- (void)collectClick
{
    _rightBarBtn.selected = !_rightBarBtn.selected;
    
    [FDQResume updateObjectInManagedObjectContext:self.managedObjectContext atModel:self.model withCollect:_rightBarBtn.selected];
}

- (void)setModel:(FDQResume *)model
{
    _model = model;
    self.title = model.name;
    
    _rightBarBtn.selected = model.collect;
    
}
@end
