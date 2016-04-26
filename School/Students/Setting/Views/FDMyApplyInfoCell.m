//
//  FDMyApplyInfoCell.m
//  School
//
//  Created by asus on 16/4/26.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyApplyInfoCell.h"
#import "FDResumejobModel.h"


#define kFontSize    14    //默认字体
#define marginH      7   //距离父控件四周距离
#define marginV      3     //控件之间的上下距离

@interface FDMyApplyInfoCell(){
    UIImageView *_iconView;   //发布者头像
    UILabel *_jobNameLab;   //工作名称
    UILabel *_departmentLab;   //部门
    UILabel *_organizationLab; //组织

}

@end


@implementation FDMyApplyInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    NSString * const cellId = @"discoverCell";
    
    FDMyApplyInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[FDMyApplyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
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

    
}



- (void)setupContraints
{
    
    [_iconView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(marginH, marginH, marginH, marginH) excludingEdge:ALEdgeRight];
    [_iconView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_iconView];
    
    [_jobNameLab sizeToFit];
    [_jobNameLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_iconView withOffset:marginV];
    [_jobNameLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:marginH];
    
    [_organizationLab sizeToFit];
    [_organizationLab autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_iconView withOffset:-marginV];
    [_organizationLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobNameLab];
    
    [_departmentLab sizeToFit];
    [_departmentLab autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_organizationLab ];
    [_departmentLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_organizationLab withOffset:marginH];
    

}

/**
 *  懒加载，设置数据
 */
- (void)setModel:(FDResumejobModel *)model
{
    _model = model;
    
    _iconView.image = [UIImage imageWithData:model.photo];
    
    _jobNameLab.text = model.jobName;
    
    _organizationLab.text = model.organization;
    
    _departmentLab.text = [NSString stringWithFormat:@"【%@】", model.department];
    

}


@end
