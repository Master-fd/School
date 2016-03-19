//
//  FDContactModel.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDContactModel : NSObject

@property (nonatomic, strong) NSData *icon;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *nikeName;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign, getter=isOnline) BOOL online;   //是否在线
@end
