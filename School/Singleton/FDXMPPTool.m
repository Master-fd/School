//
//  FDXMPPTool.m
//  School
//
//  Created by asus on 16/3/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDXMPPTool.h"


@interface FDXMPPTool()<XMPPStreamDelegate>{
    
    XMPPRequireResultBlock _requireResultBlock;
    XMPPReconnect *_reconnect;
    XMPPvCardAvatarModule *_avatar;
    XMPPvCardCoreDataStorage *_vCardStorage;
    XMPPMessageArchiving *_msgArchiVing;
}


@end
@implementation FDXMPPTool

singleton_implementation(FDXMPPTool);

/**
 *  释放资源
 */
- (void)teardownXmpp
{
    //停止模块
    [_reconnect deactivate];
    [_avatar deactivate];
    [_msgArchiVing deactivate];
    [_vCard deactivate];
    [_roster deactivate];
    
    [_xmppStream removeDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [_xmppStream disconnect];  //断开连接
    
    //清空资源
    _reconnect = nil;
    _avatar = nil;
    _vCard = nil;
    _vCardStorage = nil;
    _msgArchiVing = nil;
    _msgStorage = nil;
    _roster = nil;
    _rosterStorage = nil;
    _xmppStream = nil;
}
- (void)dealloc
{
    [self teardownXmpp];   //释放资源
}

/**
 *  初始化
 */
- (void)setupXmppStream
{
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    //联系人模块
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
    
    //电子名片
    _vCardStorage = [[XMPPvCardCoreDataStorage alloc] init];
    _vCard = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    [_vCard activate:_xmppStream];
    
    //信息模块
    _msgStorage = [[XMPPMessageArchivingCoreDataStorage alloc] init];
    _msgArchiVing = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_msgStorage];
    [_msgArchiVing activate:_xmppStream];
    
    //头像模块
    _avatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];
    [_avatar activate:_xmppStream];
    
    //重连模块
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];
    
}

/**
 *  连接服务器
 */
- (void)connectToHost
{
    
}

/**
 *  连接成功，发送密码请求授权
 */
- (void)sendPasswordToHost
{
    
}

/**
 *  授权成功,发送在线消息
 */
- (void)sendOnlineToHost
{
    
}


/**
 *  注销
 */
- (void)xmppUserLogout
{
    
}

/**
 *  登录
 */
- (void)xmppUserLogin
{
    
}

/**
 *  注册
 */
- (void)xmppUserRegister
{
    
}


#pragma mark - XMPPStream delegate

/**
 *  与主机连接成功
 */
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    
}

/**
 *  与主机断开连接
 */
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    
}

/**
 *  授权成功
 */
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    
}

/**
 *  授权失败
 */
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    
}

/**
 *  注册成功
 */
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    
}

/**
 *  注册失败
 */
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    
}





@end
