//
//  FDResumeSendMsgButtonView.m
//  School
//
//  Created by asus on 16/5/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeSendMsgButtonView.h"
#import "FDJobModel.h"

#define kMarginMax      15    //按键与四周的距离
#define kMarginMin   5


@interface FDResumeSendMsgButtonView(){
    UIView *_bgView;
    
}

@end


@implementation FDResumeSendMsgButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}


- (void)setupViews
{
    _bgView = [[UIView alloc] init];
    [self addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];

    _sendMessageBtn = [[UIButton alloc] init];
    [_bgView addSubview:_sendMessageBtn];
    _sendMessageBtn.layer.masksToBounds = YES;
    _sendMessageBtn.layer.cornerRadius = 5;
    [_sendMessageBtn setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
    [_sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendMessageBtn setTitle:@"和TA聊聊" forState:UIControlStateNormal];
    _sendMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_sendMessageBtn addTarget:self action:@selector(sendMessageToXmppJidStr) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupContraints
{
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_sendMessageBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kMarginMin, kMarginMax, kMarginMin, kMarginMax)];
}

/**
 *  和TA聊聊
 */
- (void)sendMessageToXmppJidStr
{
    //跳转到聊天界面
    if (self.sendMessageToXmppJidStrBlock) {
        self.sendMessageToXmppJidStrBlock();
    }
}

@end
