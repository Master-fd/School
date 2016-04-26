//
//  FDTextView.m
//  School
//
//  Created by asus on 16/4/10.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDTextView.h"

@implementation FDTextView


/**
 *  取出之前的文字，插入新的图片
 */
- (void)insertAttributeText:(NSAttributedString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接图片，找到光标位置
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];
    
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

//插入表情图片
- (void)insertEmoji:(NSString *)emojiName
{
    if (emojiName){
        //加载图片
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:emojiName];
        CGFloat attchHW = [UIFont systemFontOfSize:16].lineHeight;
        attch.bounds = CGRectMake(0, -5, attchHW, attchHW);
        
        //带有图片的文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        [self insertAttributeText:imageStr];
        
        //设置inputtextview字体
        NSMutableAttributedString  *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0 , text.length)];
        
        self.attributedText = text;   //重新设置进去
        self.font = [UIFont systemFontOfSize:16];   //也要重新设置一遍font,等下输入文字的时候才不会有错
    }
}

/**
 *  插入Emoji表情的名称
 */
- (void)insertEmojiName:(NSString *)emojiName doType:(BOOL) deleteBack
{
    //将表情名字封装一个[]
    emojiName = [NSString stringWithFormat:@"[%@]", emojiName];
    
    FDLog(@"insert emojiname %@", emojiName);
    if (deleteBack) {
        //删除表情
        self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(self.selectedRange.location-5, 5) withString:@""];
    } else {
        //插入表情
        [self insertText:emojiName];
    }
}


/**
 selectedRange :
 1.本来是用来控制textView的文字选中范围
 2.如果selectedRange.length为0，selectedRange.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字（text），文字大小由textView.font控制
 2.如果是属性文字（attributedText），文字大小不受textView.font控制，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 **/

@end
