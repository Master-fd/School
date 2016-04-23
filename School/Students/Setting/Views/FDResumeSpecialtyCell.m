//
//  FDResumeSpecialtyCell.m
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeSpecialtyCell.h"

#define kCellHeight     80
#define kmarge          15
#define kfontSize       14
@interface FDResumeSpecialtyCell(){
    UIView *_bgView;
    UIButton *_editBtn;
    UILabel *_specialtyLabOne;
    UILabel *_specialtyLabTwo;

}


@end

@implementation FDResumeSpecialtyCell

+ (FDResumeSpecialtyCell *)cellWithTableView:(UITableView *)tableView 
{
    NSString * const CellId = @"specialtyCell";
    FDResumeSpecialtyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumeSpecialtyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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
    
    _specialtyLabOne = [[UILabel alloc] init];
    [_bgView addSubview:_specialtyLabOne];
    _specialtyLabOne.font = [UIFont systemFontOfSize:kfontSize];
    _specialtyLabOne.textColor = [UIColor grayColor];
    _specialtyLabOne.text = @"特长一：";
    
    _specialtyLabTwo = [[UILabel alloc] init];
    [_bgView addSubview:_specialtyLabTwo];
    _specialtyLabTwo.font = [UIFont systemFontOfSize:kfontSize];
    _specialtyLabTwo.textColor = [UIColor grayColor];
    _specialtyLabTwo.text = @"特长二：";
    

    
    /*****************************************/

    _specialtyOne = [[UILabel alloc] init];
    [_bgView addSubview:_specialtyOne];
    _specialtyOne.font = [UIFont systemFontOfSize:kfontSize];
    _specialtyOne.textColor = [UIColor grayColor];
    
    _specialtyTwo = [[UILabel alloc] init];
    [_bgView addSubview:_specialtyTwo];
    _specialtyTwo.font = [UIFont systemFontOfSize:kfontSize];
    _specialtyTwo.textColor = [UIColor grayColor];
    

    
}



- (void)setupContraints
{
    
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    [_specialtyLabOne sizeToFit];
    [_specialtyLabOne autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kmarge];
    [_specialtyLabOne autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kmarge];
    [_specialtyLabOne autoSetDimension:ALDimensionWidth toSize:60];
    
    [_specialtyLabTwo sizeToFit];
    [_specialtyLabTwo autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_specialtyLabOne];
    [_specialtyLabTwo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_specialtyLabOne withOffset:kmarge];
    [_specialtyLabTwo autoSetDimension:ALDimensionWidth toSize:60];
    
    [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    [_editBtn autoSetDimensionsToSize:CGSizeMake(45, 13)];
    [_editBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_specialtyLabOne];
    
    /****************************************************************/
    
    
    [_specialtyOne autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_specialtyLabOne withOffset:5];
    [_specialtyOne autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_specialtyLabOne];
    [_specialtyOne autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_specialtyLabOne];
    [_specialtyOne autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_editBtn withOffset:-5];
    
    [_specialtyTwo autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_specialtyLabTwo withOffset:5];
    [_specialtyTwo autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_specialtyLabTwo];
    [_specialtyTwo autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_specialtyLabTwo];
    [_specialtyTwo autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    
    
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
