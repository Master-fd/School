//
//  FDEmojiCollectionViewCell.m
//  School
//
//  Created by asus on 16/4/10.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEmojiCollectionViewCell.h"
#import "FDEmojiModel.h"


@interface FDEmojiCollectionViewCell(){
    UIImageView *_EmojiView;
}

@end


@implementation FDEmojiCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}

/**
 *  添加cell的子控件
 */
- (void)setupViews
{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _EmojiView = [[UIImageView alloc] init];
    [self.contentView addSubview:_EmojiView];
}

/**
 *  设置子控件约束
 */
- (void)setupContraints
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_EmojiView autoPinEdgesToSuperviewEdgesWithInsets:insets];
}

/**
 *  设置数据
 */
- (void)setModel:(FDEmojiModel *)model
{
    _model = model;
    _EmojiView.image = [UIImage imageNamed:model.emojiName];
}
@end
