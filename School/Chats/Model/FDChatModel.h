//
//  FDChatModel.h
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    //时间
    FDChatCellType_Time  = 0,
    
    //文本
    FDChatCellType_Text  = 1,
    
    //图片
    FDChatCellType_Image = 2,
    
    //语音
    FDChatCellType_Voise = 3
    
}FDChatCellType;

#define kTimeCellReusedID        (@"time")
//cell的重用ID，根据model来区分
#define kCellReuseIDWithSenderAndType(isMeSender,chatCellType)    ([NSString stringWithFormat:@"%d-%d",isMeSender,chatCellType])

//根据模型得到可重用Cell的 重用ID
#define kCellReuseID(model)      ((model.chatCellType == FDChatCellType_Time)?kTimeCellReusedID:(kCellReuseIDWithSenderAndType(model.isMeSender,model.chatCellType)))


@interface FDChatModel : NSObject

//聊天内容
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSData *image;

@property (nonatomic, strong) NSData *voise;

//当前model类型
@property (nonatomic, assign) FDChatCellType chatCellType;

//是否是自己发送的消息, yes为自己发送
@property (nonatomic, assign, getter=isMeSender) BOOL meSender;

@end
