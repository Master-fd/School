//
//  FDResumeSendMsgButtonView.h
//  School
//
//  Created by asus on 16/5/7.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDResumeSendMsgButtonView : UIView

@property (nonatomic, strong) UIButton *sendMessageBtn;

@property (nonatomic, copy) void(^sendMessageToXmppJidStrBlock)();

@end
