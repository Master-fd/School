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

#define BgToHeadIconTop         (10)   //BG距离头像top距离
#define BgToHeadIconLorR        (10)   //BG与头像左右距离
#define BgToContentMargin       (10)    //BG距离信息内容距离

#define ContentToHeadIconTop             (BgToContentMargin + BgToHeadIconTop)    //信息内容与头像top距离
#define ContentToHeadIconLorR             (BgToContentMargin + BgToHeadIconLorR)    //信息内容与头像左右距离
#define ContentToSuperLorR      (HeadIconSize + ContentToHeadIconLorR)   //信息距离夫视图左右最低距离
#define ContentToSuperBottom    (BgToContentMargin + 10)   //信息距离父视图底部距离

@interface FDBaseChatViewCell : UITableViewCell

//头像
@property (nonatomic, strong) UIButton *headIconBtn;

//消息内容背景
@property (nonatomic, strong) UIImageView *contentBg;

@property (nonatomic, strong) FDChatModel *chatmodel;
//子类需要实现的长按方法
- (void)bgDidLongPressGesture:(UILongPressGestureRecognizer *)longPress;

@end
