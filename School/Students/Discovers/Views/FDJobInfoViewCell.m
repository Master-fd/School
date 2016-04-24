//
//  FDJobInfoView.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDJobInfoViewCell.h"
#import "FDJobModel.h"

#define kFontSize    14    //默认字体
#define kIconHW      50    //头像大小
#define marginMax      15   //距离父控件四周距离
#define marginMin      5     //控件之间的上下距离
#define kCellHeight    180      //cell高度

@interface FDJobInfoViewCell(){
    UIImageView *_iconView;   //发布者头像
    UILabel *_jobNameLab;   //工作名称
    UILabel *_departmentLab;   //部门
    UILabel *_organizationLab; //组织
    UILabel *_countLab;      //人数
    UILabel *_jobHarvestLab;  //“收获”
    UIView *_gapView;
    
}

@end


@implementation FDJobInfoViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    NSString * const cellId = @"jobInfoCellId";
    
    FDJobInfoViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FDJobInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}


- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _jobNameLab = [[UILabel alloc] init];   //工作名称
    [self addSubview:_jobNameLab];
    _jobNameLab.font= [UIFont boldSystemFontOfSize:kFontSize + 2];
    _jobNameLab.textColor = [UIColor blackColor];
    
    _countLab = [[UILabel alloc] init];
    [self addSubview:_countLab];//人数
    _countLab.font = [UIFont boldSystemFontOfSize:kFontSize + 2];
    _countLab.textColor = [UIColor orangeColor];
    _countLab.textAlignment = NSTextAlignmentCenter;
    
    _jobHarvestLab = [[UILabel alloc] init];   //"职位诱惑"
    [self addSubview:_jobHarvestLab];
    _jobHarvestLab.font= [UIFont systemFontOfSize:kFontSize];
    _jobHarvestLab.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    _jobHarvestLab.text = @"职位诱惑:";
    _jobHarvestLab.numberOfLines = 0;
    
/********************************************************************************/
    _gapView = [[UIView alloc] init];  //分割线
    [self addSubview:_gapView];
    _gapView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
/***************************************************************************************/
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_headimge_placeholder"]];   //发布者头像
    [self addSubview:_iconView];
    _iconView.layer.cornerRadius = 4;
    _iconView.layer.masksToBounds = YES;
    
    _organizationLab = [[UILabel alloc] init];   //组织
    [self addSubview:_organizationLab];
    _organizationLab.font = [UIFont boldSystemFontOfSize:kFontSize + 1];
    _organizationLab.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    
    _departmentLab = [[UILabel alloc] init];   //部门
    [self addSubview:_departmentLab];
    _departmentLab.font = [UIFont systemFontOfSize:kFontSize];
    _departmentLab.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    

}



- (void)setupContraints
{
    
    [_jobNameLab sizeToFit];
    [_jobNameLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginMax];
    [_jobNameLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginMax];

    [_countLab sizeToFit];
    [_countLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_jobNameLab];
    [_countLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_jobNameLab withOffset:marginMin];
    
    [_jobHarvestLab sizeToFit];
    [_jobHarvestLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobNameLab];
    [_jobHarvestLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobNameLab withOffset:marginMax];
    [_jobHarvestLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:marginMax];
    
/****************************************************************************************/
    [_gapView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobHarvestLab withOffset:marginMax];
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

/**
 *  懒加载，设置数据
 */
- (void)setModel:(FDJobModel *)model
{
    _model = model;
    
    _iconView.image = [UIImage imageWithData:model.icon];
    
    _jobHarvestLab.text = [NSString stringWithFormat:@"职位诱惑：%@", model.jobHarvest];
    
    _jobNameLab.text = model.jobName;
    
    _organizationLab.text = model.organization;
    
    _departmentLab.text = model.department;
    
    _countLab.text = [NSString stringWithFormat:@"【%@】", model.jobCount];
    
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
