//
//  FDChatVoiseView.m
//  School
//
//  Created by asus on 16/3/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

//添加约束崩溃，有待解决
#import "FDChatVoiseView.h"

@interface FDChatVoiseView(){
    
    UILabel *_voiselab;
    
    UIButton *_voiseBtn;
}

@end
@implementation FDChatVoiseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self setupViews];
        
        [self setupContrains];
    }
    
    return self;
}

- (void)setupViews
{
    //_voiselab
    _voiselab = [[UILabel alloc] init];
    [self addSubview:_voiselab];
    _voiselab.textColor = [UIColor clearColor];
    _voiselab.text = @"按住说话";
    _voiselab.textAlignment = NSTextAlignmentCenter;
    _voiselab.font = [UIFont systemFontOfSize:14];
    
    //_voiseBtn
    _voiseBtn = [[UIButton alloc ] init];
    _voiseBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_voiseBtn];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_highlight"] forState:UIControlStateNormal];
}

- (void)setupContrains
{
    //_voiselab
    [_voiselab sizeToFit];
    [_voiselab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_voiselab autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    //_voiseBtn
    [_voiseBtn autoSetDimensionsToSize:CGSizeMake(100, 100)];
    [_voiseBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_voiseBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_voiselab withOffset:25];
}

/**
 *  设置自己的固有尺寸
 *
 *  @return 只设置高度
 */
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, 170);
}

@end
