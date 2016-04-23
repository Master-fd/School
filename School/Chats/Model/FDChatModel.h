//
//  FDChatModel.h
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>


//cell的重用ID，根据model来区分
#define kCellReuseIDWithSenderAndType(isOutgoing)    ([NSString stringWithFormat:@"%d-ReuseID",isOutgoing])

#define kReuseIDSeparate  @"-"

@interface FDChatModel : NSObject

//聊天内容
@property (nonatomic, strong) NSString *body;   //包括图文混排

@property (nonatomic, strong) NSDate *timestamp;


//是否是自己发送的消息, yes为自己发送
@property (nonatomic, assign, getter=isOutgoing) BOOL outgoing;

@end
