//
//  FDUserInfo.h
//  School
//
//  Created by asus on 16/3/9.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDUserInfo : NSObject

//单例
singleton_interface(FDUserInfo);


/**
 *  账户
 */
@property (nonatomic, copy) NSString *account;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *password;

/**
 *  注册账户
 */
@property (nonatomic, copy) NSString *registerAccount;

/**
 *  注册密码
 */
@property (nonatomic, copy) NSString *registerPassword;

/**
 *  组织
 */
@property (nonatomic, copy) NSString *organization;

/**
 *  部门
 */
@property (nonatomic, copy) NSString *department;

/**
 *  登录状态,确认用户是否登录过
 */
@property (nonatomic, assign, getter=isLoginStatus) BOOL loginStatus;

/**
 *  从沙盒获取用户信息
 */
- (void)readUserInfoFromSabox;

/**
 *  将用户信息写人沙盒
 */
- (void)writeUserInfoToSabox;



@end
