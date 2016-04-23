//
//  FDResumeExperienceCell.m
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeExperienceCell.h"

#define kCellHeight     180
#define kfontSize       14
#define kmarge          15  //行与行之间的间隔
@interface FDResumeExperienceCell(){
    UIView *_bgView;
    UIButton *_editBtn;
    UILabel *_jobContentLab;
    UILabel *_jobTitleLab;
}


@end

@implementation FDResumeExperienceCell

+ (FDResumeExperienceCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * const CellId = @"experienceCell";
    FDResumeExperienceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumeExperienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    
    _editBtn = [[UIButton alloc] init];
    [_bgView addSubview:_editBtn];
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"icon_edit_text"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchDown];
    
    _jobTitleLab = [[UILabel alloc] init];
    [_bgView addSubview:_jobTitleLab];
    _jobTitleLab.font = [UIFont systemFontOfSize:kfontSize];
    _jobTitleLab.textColor = [UIColor grayColor];
    _jobTitleLab.text = @"职     位：";
    
    _jobContentLab = [[UILabel alloc] init];
    [_bgView addSubview:_jobContentLab];
    _jobContentLab.font = [UIFont systemFontOfSize:kfontSize];
    _jobContentLab.textColor = [UIColor grayColor];
    _jobContentLab.text = @"工作内容";
    
    /*****************************************/
    _jobTitle = [[UILabel alloc] init];
    [_bgView addSubview:_jobTitle];
    _jobTitle.font = [UIFont systemFontOfSize:kfontSize];
    _jobTitle.textColor = [UIColor grayColor];
    
    
    _jobContent = [[UITextView alloc] init];
    [_bgView addSubview:_jobContent];
    _jobContent.font = [UIFont systemFontOfSize:kfontSize];
    _jobContent.textColor = [UIColor grayColor];
}



- (void)setupContraints
{
    
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    [_jobTitleLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kmarge];
    [_jobTitleLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kmarge];
    [_jobTitleLab autoSetDimensionsToSize:CGSizeMake(70, 20)];
    
    [_jobContentLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_jobTitleLab];
    [_jobContentLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobTitleLab withOffset:kmarge];
    [_jobContentLab autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_jobTitleLab];
    [_jobContentLab autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_jobTitleLab];
    
    [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    [_editBtn autoSetDimensionsToSize:CGSizeMake(45, 13)];
    [_editBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_jobTitleLab];
    
    /****************************************************************/
    
    
    [_jobTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_jobTitleLab withOffset:5];
    [_jobTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_jobTitleLab];
    [_jobTitle autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_jobTitleLab];
    [_jobTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_editBtn withOffset:-5];
    
    [_jobContent autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kmarge];
    [_jobContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jobContentLab];
    [_jobContent autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kmarge];
    [_jobContent autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    
}


#pragma mark - 公共方法

//修改按钮被点击
- (void)editBtnClick
{
    if (self.infoBlock) {
        self.infoBlock();
    }
}


//设置固有高度
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kCellHeight);
}

+ (CGFloat)height
{
    return kCellHeight;
}

@end
