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
 *  是否是组织标志
 */
@property (nonatomic, assign, getter=isOrganizationFlag) BOOL organizationFlag;

/**
 *  账户
 */
@property (nonatomic, copy) NSString *account;

/**
 *  JID
 */
@property (nonatomic, strong) XMPPJID *jid;

/**
 *  jidStr
 */
@property (nonatomic, copy) NSString *jidStr;


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
 *  登录状态,确认用户是否登录过
 */
@property (nonatomic, assign, getter=isLoginStatus) BOOL loginStatus;

/**
 *  确认用户是否在线，应用程序没有退出，只是IOS息屏断网使用
 */
@property (nonatomic, assign, getter=isOnlineStatus) BOOL onlineStatus;



/**
 *  从沙盒获取用户信息
 */
- (void)readUserInfoFromSabox;

/**
 *  将用户信息写人沙盒
 */
- (void)writeUserInfoToSabox;



@end
