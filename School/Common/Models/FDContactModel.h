//
//  FDContactModel.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FDContactModel : NSObject

//这些名称字母必须完全和xmpp向对应,名称可以减少,但是不能出现没有的
/**
 *  好友头像
 */
@property (nonatomic, strong) NSData *photo;

/**
 *  好友nickname
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  分组名
 */
@property (nonatomic, copy) NSString *displayName;

/**
 *  好友jidstr
 */
@property (nonatomic, copy) NSString *jidStr;


@end
