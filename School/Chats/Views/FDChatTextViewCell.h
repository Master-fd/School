//
//  FDChatTextViewCell.h
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseChatViewCell.h"
#import "FDChatModel.h"

@interface FDChatTextViewCell : FDBaseChatViewCell

//聊天内容
@property (nonatomic, strong) FDChatModel *chatModel;

@end
