//
//  FDAboutFriendController.h
//  School
//
//  Created by asus on 16/4/25.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDAboutFriendController : UITableViewController

/**
 *  好友jidstr
 */
@property (nonatomic, copy) NSString *jidStr;

/**
 *  备注 ,其实每个好友在添加的时候就已经有一个备注，这个备注是默认的就是好友账号
 */
@property (nonatomic, copy) NSString *nickname;

@end
