//
//  FDEmojiModel.h
//  School
//
//  Created by asus on 16/4/10.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    /**
     *  小表情
     */
    EmojiTypeSmallImage = 0,
    /**
     *  大表情
     */
    EmojiTypeBigImage = 1,
    /**
     *  gif 动画
     */
    EmojiTypeGifImage = 2
    
}FDEmojiType;

@interface FDEmojiModel : NSObject

@property (nonatomic, assign) FDEmojiType emojiType;

@property (nonatomic, copy) NSString *emojiName;

@end
