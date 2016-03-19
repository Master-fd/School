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


@interface FDChatModel : NSObject

//聊天内容
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSData *image;

@property (nonatomic, strong) NSData *voise;


@end
