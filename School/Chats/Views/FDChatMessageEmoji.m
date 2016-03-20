//
//  FDChatMessageEmoji.m
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatMessageEmoji.h"

@implementation FDChatMessageEmoji


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupViews];

    }
    
    return self;
}
/**
 *  初始化添加views
 */
- (void)setupViews
{
    self.backgroundColor = [UIColor redColor];
}

/**
 *  设置自己的初始固有尺寸。只设置高度为170 宽度不设置
 */
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, 170);
}

@end
