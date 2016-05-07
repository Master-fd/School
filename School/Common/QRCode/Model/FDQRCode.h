//
//  FDQRCode.h
//  School
//
//  Created by asus on 16/5/6.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDQRCode : NSObject

/**
 * 创建二维码CIImage
 */
+ (CIImage *)createQRCodeImage:(NSString *)source;

/**
 *  重绘，修改CIImage大小,创建一个UIImage图片
 */
+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size;

/**
 *  在二维码中间添加图片
 */
+(UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;

/**
 *  用于生成二维码的字符串string,生成size大小的uiimage二维码
 */
+ (UIImage *)createQRCodeWithString:(NSString *)string atSize:(CGSize)size;


@end
