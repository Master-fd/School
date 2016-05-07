//
//  FDResumePurposeCell.m
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumePurposeCell.h"

#define kCellHeight     80
#define kmarge          15
#define kfontSize       14

@interface FDResumePurposeCell(){
    UIView *_bgView;
    UIButton *_editBtn;
    UILabel *_purposeLabOne;
    UILabel *_purposeLabTwo;
}


@end

@implementation FDResumePurposeCell

+ (FDResumePurposeCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * const CellId = @"purposeCell";
    FDResumePurposeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumePurposeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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

    
    _purposeLabOne = [[UILabel alloc] init];
    [_bgView addSubview:_purposeLabOne];
    _purposeLabOne.font = [UIFont systemFontOfSize:kfontSize];
    _purposeLabOne.textColor = [UIColor grayColor];
    _purposeLabOne.text = @"职    位：";
    
    _purposeLabTwo = [[UILabel alloc] init];
    [_bgView addSubview:_purposeLabTwo];
    _purposeLabTwo.font = [UIFont systemFontOfSize:kfontSize];
    _purposeLabTwo.textColor = [UIColor grayColor];
    _purposeLabTwo.text = @"部    门：";
    
    
    
    /*****************************************/
    
    _purposeOne = [[UILabel alloc] init];
    [_bgView addSubview:_purposeOne];
    _purposeOne.font = [UIFont systemFontOfSize:kfontSize];
    _purposeOne.textColor = [UIColor grayColor];
    
    _department = [[UILabel alloc] init];
    [_bgView addSubview:_department];
    _department.font = [UIFont systemFontOfSize:kfontSize];
    _department.textColor = [UIColor grayColor];
    
    
    
}



- (void)setupContraints
{
    
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    [_purposeLabOne sizeToFit];
    [_purposeLabOne autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kmarge];
    [_purposeLabOne autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kmarge];
    [_purposeLabOne autoSetDimension:ALDimensionWidth toSize:60];
    
    [_purposeLabTwo sizeToFit];
    [_purposeLabTwo autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_purposeLabOne];
    [_purposeLabTwo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_purposeLabOne withOffset:kmarge];
    [_purposeLabTwo autoSetDimension:ALDimensionWidth toSize:60];
    
    [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    [_editBtn autoSetDimensionsToSize:CGSizeMake(45, 13)];
    [_editBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_purposeLabOne];
    
    /****************************************************************/
    
    
    [_purposeOne autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_purposeLabOne withOffset:5];
    [_purposeOne autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_purposeLabOne];
    [_purposeOne autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_purposeLabOne];
    [_purposeOne autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_editBtn withOffset:-5];
    
    [_department autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_purposeLabTwo withOffset:5];
    [_department autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_purposeLabTwo];
    [_department autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_purposeLabTwo];
    [_department autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    
    
}


#pragma mark - 公共方法
- (void)setEditEnable:(BOOL)editEnable
{
    _editEnable = editEnable;
    if (editEnable) {
        _editBtn.hidden = NO;
    }else{
        _editBtn.hidden = YES;
    }
}

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
