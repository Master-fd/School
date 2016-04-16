//
//  FDLable.m
//  School
//
//  Created by asus on 16/4/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDLable.h"

@implementation FDLable

/**
 *  取出之前的文字，插入新的图片
 */
- (void)insertAttributeText:(NSAttributedString *)text atLocation:(NSRange)range
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接图片，找到光标位置
    [attributedText replaceCharactersInRange:range withAttributedString:text];
    self.attributedText = attributedText;
}

/**
 *  将text转换成AttributedText
 */
- (void)AttributedTextFromText:(NSString *)text;
{  
    if (text){
        NSString *pattern = @"\\[[0-9]{3}\\]";
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
        NSArray *results = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
        int i=0;
        for (NSTextCheckingResult *result in results) {
            //加载图片
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            NSRange nameRange = NSMakeRange(result.range.location+1, result.range.length-2);
            attch.image = [UIImage imageNamed:[text substringWithRange:nameRange]];
            CGFloat attchHW = [UIFont systemFontOfSize:16].lineHeight;
            attch.bounds = CGRectMake(0, -5, attchHW, attchHW);
            
            //带有图片的文字
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
            
            // 将文字替换成图片
            NSRange replaceRange = NSMakeRange(result.range.location-i, result.range.length);
            [attributedText replaceCharactersInRange:replaceRange withAttributedString:imageStr];
            i += 4;  //替换之后，位置需要移动一次
        }
        self.attributedText = attributedText;
    }
}


@end
