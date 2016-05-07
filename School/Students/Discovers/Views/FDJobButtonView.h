//
//  FDJobButtonView.h
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDJobButtonView : UIView

@property (nonatomic, strong) UIButton *sendResumeBtn;
@property (nonatomic, strong) UIButton *sendMessageBtn;

@property (nonatomic, copy) void(^sendResumeToXmppJidStrBlock)();

@property (nonatomic, copy) void(^sendMessageToXmppJidStrBlock)();

@end
