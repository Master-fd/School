//
//  FDGroupModel.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FDGroupModel : NSObject

@property (nonatomic, copy) NSString *groupName;   //组名

@property (nonatomic, strong) NSArray *contacts;  //一个分组里面的所有好友,保存FDContactModel

@property (nonatomic, assign, getter=isVisible) BOOL visible;   //分组是否合并

@property (nonatomic, assign) int onlineCount;   //在线人数

@property (nonatomic, assign) int contactCount;  //好友总数

@end
