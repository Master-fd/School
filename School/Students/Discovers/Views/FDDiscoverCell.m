//
//  FDDiscoverCell.m
//  School
//
//  Created by asus on 16/4/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverCell.h"
#import "FDJobModel.h"

#define kFontSize    14    //默认字体
#define kIconHW      70    //头像大小
#define marginH      15   //距离父控件四周距离
#define marginV      5     //控件之间的上下距离
#define kCellHeight   (kIconHW + marginH + marginH)   //cell高度
@interface FDDiscoverCell(){
    UIImageView *_iconView;   //发布者头像
    UILabel *_jobNameLab;   //工作名称
    UILabel *_departmentLab;   //部门
    UILabel *_organizationLab; //组织
    UILabel *_countLab;      //人数
    UILabel *_jobCountLab;
}

@end


@implementation FDDiscoverCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    NSString * const cellId = @"discoverCell";
    
    FDDiscoverCell *cell = [tableview dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[FDDiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加控件
        [self setupViews];
        //添加约束
        [self setupContraints];
        
    }
    
    return self;
}

- (void)setupViews
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_headimge_placeholder"]];   //发布者头像
    [self.contentView addSubview:_iconView];
    _iconView.layer.cornerRadius = 4;
    _iconView.layer.masksToBounds = YES;
    
    _jobNameLab = [[UILabel alloc] init];   //工作名称
    [self.contentView addSubview:_jobNameLab];
    _jobNameLab.font= [UIFont boldSystemFontOfSize:kFontSize + 1];
    _jobNameLab.textColor = [UIColor blackColor];
    
    _departmentLab = [[UILabel alloc] init];   //部门
    [self.contentView addSubview:_departmentLab];
    _departmentLab.font = [UIFont systemFontOfSize:kFontSize];
    _departmentLab.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    
    _organizationLab = [[UILabel alloc] init];   //组织
    [self.contentView addSubview:_organizationLab];
    _organizationLab.font = [UIFont boldSystemFontOfSize:kFontSize];
    _organizationLab.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    
    _countLab = [[UILabel alloc] init];
    [self.contentView addSubview:_countLab];//人数
    _countLab.font = [UIFont systemFontOfSize:kFontSize - 1];
    _countLab.textColor = [UIColor orangeColor];
    _countLab.textAlignment = NSTextAlignmentCenter;
    
    _jobCountLab = [[UILabel alloc] init];
    [self.contentView addSubview:_jobCountLab];
    _jobCountLab.font = [UIFont systemFontOfSize:kFontSize - 1];
    _jobCountLab.text = @"人数";
    _jobCountLab.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];

}



- (void)setupContraints
{
    
    [_iconView autoSetDimensionsToSize:CGSizeMake(kIconHW, kIconHW)];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginH];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginH];
    
    [_jobNameLab autoSetDimensionsToSize:CGSizeMake(150, 20)];
    [_jobNameLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_iconView];
    [_jobNameLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:marginH];
    
    [_organizationLab autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_jobNameLab];
    [_organizationLab autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_jobNameLab];
    [_organizationLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobNameLab  withOffset:marginV];
    [_organizationLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobNameLab];
    
    [_departmentLab autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_organizationLab];
    [_departmentLab autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_organizationLab];
    [_departmentLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_organizationLab  withOffset:marginV];
    [_departmentLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_organizationLab];

    [_jobCountLab autoSetDimensionsToSize:CGSizeMake(30, 15)];
    [_jobCountLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_iconView];
    [_jobCountLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:marginH];
    
    [_countLab autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_jobCountLab];
    [_countLab autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_jobCountLab];
    [_countLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobCountLab  withOffset:marginV];
    [_countLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobCountLab];
}

/**
 *  懒加载，设置数据
 */
- (void)setModel:(FDJobModel *)model
{
    _model = model;
    
    _iconView.image = [UIImage imageWithData:model.icon];
    
    _jobNameLab.text = model.jobName;
    
    _organizationLab.text = model.organization;
    
    _departmentLab.text = model.department;
    
    _countLab.text = model.jobCount;
    
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




