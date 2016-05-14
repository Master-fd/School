//
//  FDBaseChatViewCell.h
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDChatModel.h"
#import "UIResponder+FDExtension.h"

#define HeadIconToSuper         (10)    //头像距离父视图距离
#define HeadIconSize            (40)    //头像大小

#define BgToHeadIconTop         (4)   //BG距离头像top距离
#define BgToHeadIconLorR        (8)   //BG与头像左右距离
#define BgToContentTopMargin       (9)    //BG距离信息top内容距离
#define BgToContentBottomMargin       (15)    //BG距离信息bottm内容距离
#define BgToContentLorRMargin       (15)    //BG距离信息lr内容距离

#define ContentToHeadIconTop             (BgToContentTopMargin + BgToHeadIconTop)    //信息内容与头像top距离
#define ContentToHeadIconLorR             (BgToContentLorRMargin + BgToHeadIconLorR)    //信息内容与头像左右距离
#define ContentToSuperLorR      (HeadIconSize + ContentToHeadIconLorR)   //信息距离夫视图左右最低距离
#define ContentToSuperBottom    (BgToContentBottomMargin + 5)   //信息距离父视图底部距离

@interface FDBaseChatViewCell : UITableViewCell

//头像
@property (nonatomic, strong) UIImageView *headIconBtn;

//消息内容背景
@property (nonatomic, strong) UIImageView *contentBg;

@property (nonatomic, strong) FDChatModel *chatmodel; //消息模型

@property (nonatomic, assign, getter=isSender) BOOL sender;  //消息发送者
//子类需要实现的长按方法
- (void)bgDidLongPressGesture:(UILongPressGestureRecognizer *)longPress;

@end
