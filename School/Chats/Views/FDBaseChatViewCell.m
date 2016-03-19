//
//  FDBaseChatViewCell.m
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseChatViewCell.h"

@implementation FDBaseChatViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加view
        [self setupViews];
        //添加约束
        [self setupContraint];
    }
    
    return self;
}

/**
 *  添加view
 */
- (void)setupViews
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;   //设置选定是无变化
    
    _headIconBtn = [[UIButton alloc] init];
    [self.contentView addSubview:_headIconBtn];
    _headIconBtn.backgroundColor = [UIColor clearColor];
    [_headIconBtn setImage:[UIImage imageNamed:@"user_avatar_default"] forState:UIControlStateNormal];
    [_headIconBtn addTarget:self action:@selector(headIconBtnClick) forControlEvents:UIControlEventTouchDown];
    
    _contentBg = [[UIImageView alloc] init];
    [self.contentView addSubview:_contentBg];
    
    if (self.isMeSender) {
        //自己发送的信息
        _contentBg.image = [[UIImage imageNamed:@"chat_send_nor"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        _contentBg.highlightedImage = [[UIImage imageNamed:@"chat_send_press_pic"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    }else{
        //接收的信息
        _contentBg.image = [[UIImage imageNamed:@"chat_recive_nor"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
        _contentBg.highlightedImage = [[UIImage imageNamed:@"chat_recive_press_pic"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];
    }
    
}

/**
 *  添加约束
 */
- (void)setupContraint
{
    //确定headIconBtn的 x。y和w。h
    [_headIconBtn autoSetDimensionsToSize:CGSizeMake(HeadIconSize, HeadIconSize)];
    [_headIconBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:HeadIconToSuper];
    if (self.isMeSender) {
        [_headIconBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:HeadIconToSuper];
    } else {
        [_headIconBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:HeadIconToSuper];
    }
    //确定_contentBg的X y  宽和高需要等待信息内容确定之后才可以确定
    [_contentBg autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_headIconBtn withOffset:BgToHeadIconTop];
    if (self.isMeSender) {
        [_contentBg autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_headIconBtn withOffset:BgToHeadIconLorR];
    }else{
        [_contentBg autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_headIconBtn withOffset:BgToHeadIconLorR];
    }
    
}

/**
 *  头像被单击，调用block
 */
- (void)headIconBtnClick
{
    if (_headIconBtnDidClickBlock) {
        _headIconBtnDidClickBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
