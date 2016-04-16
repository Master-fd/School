//
//  FDChatInputBar.h
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDChatMessageEmoji.h"


#define   kInputBarFrameDidChangeNotification   @"InputBarFrameDidChangeNotification "

@interface FDChatInputBar : UIView

/**
 *  @brief  录制语音按钮
 */
@property (nonatomic, strong) UIButton *voiseBtn;

/**
 *  @brief  表情按钮
 */
@property (nonatomic, strong) UIButton *faceBtn;



- (void)voiseBtnDidClick:(UIButton *)sender;
- (void)faceBtnDidClick:(UIButton *)sender;

@end
