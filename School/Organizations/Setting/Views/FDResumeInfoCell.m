//
//  FDResumeInfoCell.m
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeInfoCell.h"
#import "FDQResume+FDCoreDataProperties.h"



#define kFontSize    14    //默认字体
#define marginMax      10   //距离父控件四周距离

@interface FDResumeInfoCell(){
    
    UIImageView *_iconView;
    
    UILabel *_jobNameLab;
    
    UILabel *_departmentLab;
    
    UIImageView *_collectView;  //收藏标志
}

@end


@implementation FDResumeInfoCell

+ (FDResumeInfoCell *)cellForTableView:(UITableView *)tableView;
{
    NSString * const CellId = @"Cell";
    FDResumeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_headimge_placeholder"]];   //应聘者头像
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
    
    _collectView = [[UIImageView alloc] init];
    [self.contentView addSubview:_collectView];
    _collectView.backgroundColor = [UIColor clearColor];
    _collectView.image = [UIImage imageNamed:@"icon_star_select"];
    _collectView.hidden = YES;
}



- (void)setupContraints
{
    
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:marginMax];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginMax];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginMax];
    [_iconView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_iconView];
    
    [_jobNameLab sizeToFit];
    [_jobNameLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_iconView];
    [_jobNameLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:marginMax];

    [_departmentLab sizeToFit];
    [_departmentLab autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_iconView];
    [_departmentLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobNameLab];
    
    [_collectView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_jobNameLab];
    [_collectView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_jobNameLab];
    [_collectView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:_collectView];
    [_collectView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_jobNameLab withOffset:marginMax];
    

}

- (void)setModel:(FDQResume *)model
{
    _model = model;
    
    if (model.photo) {
        _iconView.image = [UIImage imageWithData:model.photo];
    } else {
        _iconView.image = [UIImage imageNamed:@"icon_headimge_placeholder"];
    }
    _departmentLab.text = model.department;
    _jobNameLab.text = model.jobTitle;
    _collectView.hidden = !model.collect;
}


@end
