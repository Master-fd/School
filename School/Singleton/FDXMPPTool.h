//
//  FDXMPPTool.h
//  School
//
//  Created by asus on 16/3/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

@interface FDXMPPTool : NSObject

singleton_interface(FDXMPPTool);


typedef enum {
    XMPPRequireResultTypeLoginSuccess,   //登录成功
    XMPPRequireResultTypeLoginFailure,    //登录失败
    XMPPRequireResultTypeNetError,           //网络错误
    XMPPRequireResultTypeRegisterSuccess,       //注册成功
    XMPPRequireResultTypeRegisterFailure,       //注册失败
}XMPPRequireResultType;


typedef void (^XMPPRequireResultBlock)(XMPPRequireResultType type);


@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *vCard;
@property (nonatomic, strong, readonly) XMPPRoster *roster;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *rosterStorage;
@property (nonatomic, strong, readonly) XMPPMessageArchivingCoreDataStorage *msgStorage;

/**
 *  当前是否是注册操作
 */
@property (nonatomic, assign, getter=isRegisterOperation) BOOL registerOperation;

/**
 *  用户注销
 */
- (void)xmppUserLogout;

/**
 *  用户注册
 */
- (void)xmppUserRegister;

/**
 *  用户登录
 */
- (void)xmppUserLogin;



@end
