//
//  FDChatMessageEmoji.h
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FDEmojiModel;
/**
 *  表情个数
 */
#define kEmojiCount  141

/**
 *  cell重用id
 */
#define kReuseCellId    @"ReuseCellId"

/**
 *  face view高度
 */
#define kHeightFaceView  170

/**
 *  emojibtn size
 */
#define kHeightBtn         30

/**
 *  pagecontrol未选中的颜色
 */
#define kUnSelectedColorPageControl   ([UIColor colorWithRed:0.604 green:0.608 blue:0.616 alpha:1])

/**
 *  pagecontrol选中的颜色
 */
#define kSelectedColorPageControl     ([UIColor colorWithRed:0.380 green:0.416 blue:0.463 alpha:1])


typedef enum{
    
    deleteEmoji = 0,
    
    addEmoji = 1
}doType;

typedef void(^emojiHasClickBlock)(FDEmojiModel *model, doType type);

@interface FDChatMessageEmoji : UIView

@property (nonatomic, copy) emojiHasClickBlock emojiBlock;


@end
