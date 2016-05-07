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


typedef void (^XMPPRequireResultBlock)(XMPPRequireResultType type);   //定义连接block


@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *vCard;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule *avatar;
@property (nonatomic, strong, readonly) XMPPRoster *roster;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *rosterStorage;
@property (nonatomic, strong, readonly) XMPPMessageArchivingCoreDataStorage *msgStorage;

/**
 *  当前是否是注册操作
 */
@property (nonatomic, assign, getter=isRegisterOperation) BOOL registerOperation;
/**
 *  注册操作，检测下一步继续完成信息是否完毕
 */
@property (nonatomic, assign, getter=isInfoComplete) BOOL infoComplete;
/**
 *  用户注销登录
 */
- (void)xmppUserLogout;

/**
 *  用户连接主机,登录和注册
 */
- (void)xmppUserConnetToHost:(XMPPRequireResultBlock)requireResultBlock;

/**
 *  根据传入的JID，获取获取对应的Vcard
 */
- (XMPPvCardTemp *)xmppvCardTempForJID:(XMPPJID *)jid shouldFetch:(BOOL)shouldFetch;

/**
 *  根据传入的jidstr  获取用户vcard
 */
- (XMPPvCardTemp *)xmppvCardTempForJIDStr:(NSString *)jidStr shouldFetch:(BOOL)shouldFetch;

/**
 *  根据传入的jidstr  获取用户vcard,vcard会缓存，有缓存则不联网读取,使用在联系人列表
 */
- (XMPPvCardTemp *)xmppvCardTempForJIDStr:(NSString *)jidStr;

/**
 *  更新自己给用户设置的备注
 */
- (void)xmppUpdateNickname:(NSString *)nickname forUserJidStr:(NSString *)jidStr;

/**
 *  联网添加好友
 */
- (void)addFriend:(NSString *)account;

@end
