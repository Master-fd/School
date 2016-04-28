//
//  FDEditJobInfoCell.m
//  School
//
//  Created by asus on 16/4/27.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditJobInfoView.h"
#import "FDJobModel.h"
#import "FDOrganization.h"


#define kFontSize    14    //默认字体
#define kIconHW      50    //头像大小
#define marginMax      15   //距离父控件四周距离
#define marginMin      5     //控件之间的上下距离
#define kCellHeight    200   //固有高度

@interface FDEditJobInfoView(){
    UIImageView *_iconView;   //发布者头像
    UILabel *_organizationLab; //组织
    UILabel *_jobHarvestLab;  //“职位诱惑”
    UIView *_gapView;
    
}

@end


@implementation FDEditJobInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}


- (void)setupViews
{
   
    self.backgroundColor = [UIColor whiteColor];
    
    _jobNameTextField = [[UITextField alloc] init];   //工作名称
    [self addSubview:_jobNameTextField];
    _jobNameTextField.font= [UIFont boldSystemFontOfSize:kFontSize + 2];
    _jobNameTextField.textColor = [UIColor blackColor];
    _jobNameTextField.placeholder = @"职位名称(必填)";
    _jobNameTextField.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
    _jobNameTextField.layer.borderWidth = 1;
    _jobNameTextField.layer.masksToBounds = YES;
    _jobNameTextField.layer.cornerRadius = 4;
    
    _countTextField = [[UITextField alloc] init];
    [self addSubview:_countTextField];//人数
    _countTextField.font = [UIFont boldSystemFontOfSize:kFontSize + 2];
    _countTextField.textColor = [UIColor orangeColor];
    _countTextField.textAlignment = NSTextAlignmentCenter;
    _countTextField.placeholder = @"招聘人数(必填)";
    _countTextField.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
    _countTextField.layer.borderWidth = 1;
    _countTextField.layer.masksToBounds = YES;
    _countTextField.layer.cornerRadius = 4;
    
    _jobHarvestLab = [[UILabel alloc] init];   //"职位诱惑"
    [self addSubview:_jobHarvestLab];
    _jobHarvestLab.font= [UIFont systemFontOfSize:kFontSize];
    _jobHarvestLab.text = @"职位诱惑:";
    
    _jobHarvesTextView = [[UITextView alloc] init];
    [self addSubview:_jobHarvesTextView];
    _jobHarvesTextView.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
    _jobHarvesTextView.layer.borderWidth = 1;
    _jobHarvesTextView.layer.masksToBounds = YES;
    _jobHarvesTextView.layer.cornerRadius = 4;
    _jobHarvesTextView.scrollEnabled = NO;
    
    /********************************************************************************/
    _gapView = [[UIView alloc] init];  //分割线
    [self addSubview:_gapView];
    _gapView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    /***************************************************************************************/
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_headimge_placeholder"]];   //发布者头像
    [self addSubview:_iconView];
    _iconView.layer.cornerRadius = 4;
    _iconView.layer.masksToBounds = YES;
    if ([FDOrganization shareFDOrganization].photo.length) {
        _iconView.image = [UIImage imageWithData:[FDOrganization shareFDOrganization].photo];
    } else {
        _iconView.image = [UIImage imageNamed:@"user_avatar_default"];
    }
    
    _organizationLab = [[UILabel alloc] init];   //组织
    [self addSubview:_organizationLab];
    _organizationLab.font = [UIFont boldSystemFontOfSize:kFontSize + 1];
    _organizationLab.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    if ([FDOrganization shareFDOrganization].nickname.length) {
        _organizationLab.text = [FDOrganization shareFDOrganization].nickname;
    } else {
        _organizationLab.text = @"无名组织";
    }
    
    _departmentLab = [[UITextField alloc] init];   //部门
    [self addSubview:_departmentLab];
    _departmentLab.font = [UIFont systemFontOfSize:kFontSize];
    _departmentLab.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    _departmentLab.placeholder = @"部门(必填)";
    _departmentLab.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
    _departmentLab.layer.borderWidth = 1;
    _departmentLab.layer.masksToBounds = YES;
    _departmentLab.layer.cornerRadius = 4;
    
}



- (void)setupContraints
{
    
    [_jobNameTextField sizeToFit];
    [_jobNameTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginMax];
    [_jobNameTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginMax];
    
    [_countTextField sizeToFit];
    [_countTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_jobNameTextField];
    [_countTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_jobNameTextField withOffset:marginMin];
    
    [_jobHarvestLab sizeToFit];
    [_jobHarvestLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobNameTextField];
    [_jobHarvestLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobNameTextField withOffset:marginMax];
    
    [_jobHarvesTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_jobHarvestLab];
    [_jobHarvesTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:marginMax];
    [_jobHarvesTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_jobHarvestLab withOffset:marginMin];
    [_jobHarvesTextView autoSetDimension:ALDimensionHeight toSize:40];
    
    /****************************************************************************************/
    [_gapView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobHarvesTextView withOffset:marginMax];
    [_gapView autoSetDimension:ALDimensionHeight toSize:0.5];  //分割线
    [_gapView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [_gapView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    /***************************************************************************************/
    
    [_iconView autoSetDimensionsToSize:CGSizeMake(kIconHW, kIconHW)];
    [_iconView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_gapView withOffset:marginMax];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginMax];
    
    [_organizationLab sizeToFit];
    [_organizationLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_iconView withOffset:marginMin];
    [_organizationLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:marginMax];
    
    [_departmentLab sizeToFit];
    [_departmentLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView  withOffset:marginMax];
    [_departmentLab autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_iconView withOffset:-marginMin];
    
}


+ (CGFloat)height
{
    return kCellHeight;
}
/**
 *  返回固有高度
 */
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kCellHeight);
}



@end
