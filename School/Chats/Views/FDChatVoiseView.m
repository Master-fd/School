//
//  FDChatVoiseView.m
//  School
//
//  Created by asus on 16/3/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

//添加约束崩溃，有待解决
#import "FDChatVoiseView.h"
#import "UIResponder+FDExtension.h"
#import "FDChatModel.h"


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
        
        [self setupViews];
        
        [self setupContrains];
    }
    
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    //_voiselab
    _voiselab = [[UILabel alloc] init];
    [self addSubview:_voiselab];
    _voiselab.textColor = [UIColor blackColor];
    _voiselab.text = @"按住说话";
    _voiselab.textAlignment = NSTextAlignmentCenter;
    _voiselab.font = [UIFont systemFontOfSize:15];
    _voiselab.alpha = 0.5;
    
    //_voiseBtn
    _voiseBtn = [[UIButton alloc ] init];
    _voiseBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:_voiseBtn];
    [_voiseBtn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_highlight"] forState:UIControlStateNormal];
    [_voiseBtn addTarget:self action:@selector(beginRecordVoiseClick) forControlEvents:UIControlEventTouchDown];
    [_voiseBtn addTarget:self action:@selector(endRecordVoiseClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupContrains
{
    //_voiselab
    [_voiselab sizeToFit];
    [_voiselab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [_voiselab autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    //_voiseBtn
    [_voiseBtn autoSetDimensionsToSize:CGSizeMake(120, 120)];
    [_voiseBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_voiseBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_voiselab withOffset:10];
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


/**
 *  开始录音
 */
- (void)beginRecordVoiseClick
{
    FDLog(@"开始录音");
}

/**
 *  结束录音
 */
- (void)endRecordVoiseClick
{
    FDLog(@"结束录音");
    
    FDChatModel *model = [[FDChatModel alloc] init];
   // model.voise = @"声音转换成二进制之后的数据";
    NSDictionary *userInfo = @{KModelKey : model};
    [self routerEventWithType:EventChatCellTypeSendMsgEvent userInfo:userInfo];   //发布路由信息，等待控制器收到信息之后处理发送
}
@end
