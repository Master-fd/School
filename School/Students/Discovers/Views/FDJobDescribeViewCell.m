//
//  FDJobDescribeView.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDJobDescribeViewCell.h"
#import "FDJobModel.h"


#define kFontSize    14    //默认字体
#define kIconW      15    //头像宽
#define kIconH      20    //头像高
#define marginMax      15   //距离父控件四周距离
#define marginMin      5     //控件之间的上下距离
#define kJobDescribeHeight    200  //职位描述高度
#define kCellHeight    (kJobDescribeHeight + kIconH + marginMax*3 + marginMin)     //cell高度

@interface FDJobDescribeViewCell(){
    UIImageView *_iconView;   //职位描述头像
    UILabel *_jobDescLab;   //"职位描述"
    UIView *_gapView;  //分割线
    UITextView *_jobDescribe;   //职位详情
}

@end


@implementation FDJobDescribeViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    NSString * const cellId = @"jobInfoCellId";
    
    FDJobDescribeViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FDJobDescribeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
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
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jd_zhiwei"]];   //职位描述头像
    [self addSubview:_iconView];
    
    _jobDescLab = [[UILabel alloc] init];   //"职位描述"
    [self addSubview:_jobDescLab];
    _jobDescLab.font= [UIFont boldSystemFontOfSize:kFontSize + 2];
    _jobDescLab.textColor = [UIColor blackColor];
    _jobDescLab.text = @"职位描述";
    
    /********************************************************************************/
    _gapView = [[UIView alloc] init];  //分割线
    [self addSubview:_gapView];
    _gapView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    /***************************************************************************************/
    
    
    _jobDescribe = [[UITextView alloc] init];   //职位描述详情
    [self addSubview:_jobDescribe];
    _jobDescribe.font = [UIFont systemFontOfSize:kFontSize + 1];
    _jobDescribe.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
    _jobDescribe.userInteractionEnabled = NO;
    


}



- (void)setupContraints
{

    [_iconView autoSetDimensionsToSize:CGSizeMake(kIconW, kIconH)];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginMax];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:marginMax];
    
    [_jobDescLab sizeToFit];
    [_jobDescLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_iconView];
    [_jobDescLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:marginMin];
    
    /****************************************************************************************/
    [_gapView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_iconView withOffset:marginMax];
    [_gapView autoSetDimension:ALDimensionHeight toSize:0.5];  //分割线
    [_gapView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [_gapView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    /***************************************************************************************/
    
    [_jobDescribe autoSetDimension:ALDimensionHeight toSize:kJobDescribeHeight];
    [_jobDescribe autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_gapView withOffset:marginMin];
    [_jobDescribe autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginMax];
    [_jobDescribe autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:marginMax];
    
    
}

/**
 *  懒加载，设置数据
 */
- (void)setModel:(FDJobModel *)model
{
    _model = model;

    _jobDescribe.text = model.jobDescribe;
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

