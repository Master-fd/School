//
//  UIResponder+FDExtension.h
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    /**
     *  删除事件
     */
    EventChatCellRemoveEvent,
    
    /**
     *  @brief  图片点击事件
     */
    EventChatCellImageTapedEvent,
    
    /**
     *  @brief  头像点击事件
     */
    EventChatCellHeadTapedEvent,
    
    /**
     *  @brief  头像长按事件
     */
    EventChatCellHeadLongPressEvent,
    
    /**
     *  @brief  输入框点击发送消息事件
     */
    EventChatCellTypeSendMsgEvent,
    
    
    /**
     *  @brief 输入界面，更多界面，选择图片
     */
    EventChatMoreViewPickerImage,

}EventChatCellType;


#define KModelKey    (@"FDModel")

@interface UIResponder (FDExtension)


/**
 *  发布一个路由器转发信息
 *  事件回调，直到可以对evenType相应的地方进行处理
 */
- (void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo;



@end
