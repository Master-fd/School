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
    //通过可从用ID的区分符号“-”，获取可知道是谁发送的信息,因为我们在新建cell的时候需要知道这个信息是谁发送的，不能等到设置数据的时候才知道，这个时候晚了。cell都已经创建好了
    
    if (self) {
        NSArray *ID = [reuseIdentifier componentsSeparatedByString:kReuseIDSeparate];
        NSAssert(ID.count>=2, @"聊天页面cell的重用reuseIdentifier有误,抛出异常 -");  //如果ID有误,抛出异常
        self.sender = [ID[0] boolValue];
        
        self.backgroundColor = [UIColor clearColor];
        //添加view
        [self superSetupViews];
        //添加约束
        [self superSetupContraint];
    }
    
    return self;
}


/**
 *  添加view
 */
- (void)superSetupViews
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;   //设置选定是无变化
    
    _headIconBtn = [[UIButton alloc] initForAutoLayout];
    [self.contentView addSubview:_headIconBtn];
    _headIconBtn.backgroundColor = [UIColor clearColor];
    _headIconBtn.layer.cornerRadius = 20;
    _headIconBtn.layer.masksToBounds = YES;
    [_headIconBtn setBackgroundImage:[UIImage imageNamed:@"user_avatar_default"] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headIconBtnDidTap:)];  //头像被单击了
    [_headIconBtn addGestureRecognizer:tapGesture];
    
    _contentBg = [[UIImageView alloc] initForAutoLayout];
    _contentBg.userInteractionEnabled = YES;
    [self.contentView addSubview:_contentBg];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(bgDidLongPressGesture:)];//内容被长按
    [_contentBg addGestureRecognizer:longPressGesture];
 
    NSUInteger chip_bounds = 30;
    if (self.isSender) {
        //自己发送的信息背景图片
        _contentBg.image = [[UIImage imageNamed:@"SenderTextNodeBkg"] stretchableImageWithLeftCapWidth:chip_bounds topCapHeight:chip_bounds];
        _contentBg.highlightedImage = [[UIImage imageNamed:@"SenderTextNodeBkgHL"] stretchableImageWithLeftCapWidth:chip_bounds topCapHeight:chip_bounds];
    }else{
        //接收的信息背景图片
        _contentBg.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"] stretchableImageWithLeftCapWidth:chip_bounds topCapHeight:chip_bounds];
        _contentBg.highlightedImage = [[UIImage imageNamed:@"ReceiverTextNodeBkgHL"] stretchableImageWithLeftCapWidth:chip_bounds topCapHeight:chip_bounds];
    }
}

/**
 *  添加约束
 */
- (void)superSetupContraint
{
    //确定headIconBtn的 y和w。h
    [_headIconBtn autoSetDimensionsToSize:CGSizeMake(HeadIconSize, HeadIconSize)];//w  h
    [_headIconBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:HeadIconToSuper]; //y
    if (self.isSender) {//x
        [_headIconBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:HeadIconToSuper];
    } else {
        [_headIconBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:HeadIconToSuper];
    }
    //确定_contentBg的X y  宽和高需要等待信息内容确定之后才可以确定
    [_contentBg autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_headIconBtn withOffset:BgToHeadIconTop];//y
    if (self.isSender) {//x
        [_contentBg autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_headIconBtn withOffset:-BgToHeadIconLorR];
    }else{
        [_contentBg autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_headIconBtn withOffset:BgToHeadIconLorR];
    }
    
}

//头像被单击
- (void)headIconBtnDidTap:(UITapGestureRecognizer *)tap
{
    FDLog(@"头像被单击");
}

//内容被长按,这个方法将会被子类覆盖
- (void)bgDidLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    FDLog(@"内容被长按");
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
