//
//  FDChatTextViewCell.m
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatTextViewCell.h"

@interface FDChatTextViewCell(){
    //聊天内容为文本信息
    UILabel *_textLab;
}

@end



@implementation FDChatTextViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        
        [self setupContraint];
    }
    
    return self;
}

/**
 *  新建views
 */
- (void)setupViews
{
    _textLab = [[UILabel alloc] init];
    [self.contentView addSubview:_textLab];
    _textLab.backgroundColor = [UIColor clearColor];
    _textLab.numberOfLines = 0;  //自动换行
    _textLab.font = [UIFont systemFontOfSize:14];
    
}


/**
 *  设置views 的约束
 */
- (void)setupContraint
{
    //设置_textLab的X Y 和宽高
    [_textLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.headIconBtn withOffset:ContentToHeadIconTop];
    [_textLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:ContentToSuperBottom];
    if (self.isMeSender) {  //自己发送的信息
        [_textLab autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.headIconBtn withOffset:ContentToHeadIconLorR];
        [_textLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:ContentToSuperLorR relation:NSLayoutRelationGreaterThanOrEqual];
    } else {//接收到的信息
        [_textLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.headIconBtn withOffset:ContentToHeadIconLorR];
        [_textLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:ContentToSuperLorR relation:NSLayoutRelationGreaterThanOrEqual];
    }
    
    //设置contentBg的宽高
    [self.contentBg autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_textLab withOffset:BgToContentMargin];
    if (self.isMeSender) {
        //自己发送的文本信息
        [self.contentBg autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_textLab withOffset:BgToContentMargin];
    }else{
        //接收到的文本信息
        [self.contentBg autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_textLab withOffset:BgToContentMargin];
    }
}


//懒加载，设置数据
- (void)setChatModel:(FDChatModel *)chatModel
{
    _chatModel = chatModel;
    _textLab.text = chatModel.text;
}

@end
