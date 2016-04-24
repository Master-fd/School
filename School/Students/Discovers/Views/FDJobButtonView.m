//
//  FDJobButtonView.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDJobButtonView.h"
#import "FDJobModel.h"

#define kMarginMax      15    //按键与四周的距离
#define kMarginMin   5


@interface FDJobButtonView(){
    UIView *_bgView;
    UIButton *_sendResumeBtn;
    UIButton *_sendMessageBtn;
}

@end
@implementation FDJobButtonView

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
    
    _sendResumeBtn = [[UIButton alloc] init];
    [_bgView addSubview:_sendResumeBtn];
    _sendResumeBtn.layer.masksToBounds = YES;
    _sendResumeBtn.layer.cornerRadius = 5;
    [_sendResumeBtn setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
    [_sendResumeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_sendResumeBtn setTitle:@"发送简历" forState:UIControlStateNormal];
    _sendResumeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_sendResumeBtn addTarget:self action:@selector(sendResumeToXmppJidStr) forControlEvents:UIControlEventTouchUpInside];
    
    _sendMessageBtn = [[UIButton alloc] init];
    [_bgView addSubview:_sendMessageBtn];
    _sendMessageBtn.layer.masksToBounds = YES;
    _sendMessageBtn.layer.cornerRadius = 5;
    [_sendMessageBtn setBackgroundColor:[UIColor grayColor]];
    [_sendMessageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendMessageBtn setTitle:@"和TA聊聊" forState:UIControlStateNormal];
    _sendMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_sendMessageBtn addTarget:self action:@selector(sendMessageToXmppJidStr) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupContraints
{
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [_sendResumeBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kMarginMin, kMarginMax, kMarginMin, kMarginMax) excludingEdge:ALEdgeRight];
    [_sendResumeBtn autoSetDimension:ALDimensionWidth toSize:([UIScreen mainScreen].bounds.size.width - kMarginMax*3) / 2.0];
    
    [_sendMessageBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kMarginMin, kMarginMax, kMarginMin, kMarginMax) excludingEdge:ALEdgeLeft];
    [_sendMessageBtn autoSetDimension:ALDimensionWidth toSize:([UIScreen mainScreen].bounds.size.width - kMarginMax*3) / 2.0];
}

/**
 *  发送简历
 */
- (void)sendResumeToXmppJidStr
{
    if (self.sendResumeToXmppJidStrBlock) {
        self.sendResumeToXmppJidStrBlock();
    }
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
