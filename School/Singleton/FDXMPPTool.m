//
//  FDXMPPTool.m
//  School
//
//  Created by asus on 16/3/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDXMPPTool.h"
#import "FDLoginController.h"


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
    //初始化模块
    if (!_xmppStream) {
        [self setupXmppStream];
    }
    
    //获取用户名
    NSString *account = nil;
    if (self.isRegisterOperation) {
        account = [FDUserInfo shareFDUserInfo].registerAccount;
    } else {
        account = [FDUserInfo shareFDUserInfo].account;
    }
    
    //设置JID
    XMPPJID *jid = [XMPPJID jidWithUser:account domain:ServerName resource:ClientName];
    [FDUserInfo shareFDUserInfo].jid = jid;
    _xmppStream.myJID = jid;
    
    //设置端口和服务器
    _xmppStream.hostName = ServerIP;   //只能填IP
    
    //连接
    _xmppStream.hostPort = ServerPort;
    
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        FDLog(@"xmpp 连接错误%@", error);
    }
}

/**
 *  连接成功，发送密码登录则请求授权，或者注册
 */
- (void)sendPasswordToHost
{
    NSString *password = nil;
    NSError *error = nil;
    
    if (self.isRegisterOperation) {
        //注册
        password = [FDUserInfo shareFDUserInfo].registerPassword;
        [_xmppStream registerWithPassword:password error:&error];
        if (error) {
            FDLog(@"发送注册密码失败%@", error);
        }
    } else {
        //登录
        password = [FDUserInfo shareFDUserInfo].password;
        [_xmppStream authenticateWithPassword:password error:&error];
        if (error) {
            FDLog(@"发送登录密码失败%@", error);
        }
    }
    
}

/**
 *  授权成功,发送在线消息
 */
- (void)sendOnlineToHost
{
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

#pragma mark - 公共方法

/**
 *  注销
 */
- (void)xmppUserLogout
{
    //发送离线消息
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    //断开连接
    [_xmppStream disconnect];
    
    //更新用户信息状态到沙盒
    [FDUserInfo shareFDUserInfo].loginStatus = NO;
    [[FDUserInfo shareFDUserInfo] writeUserInfoToSabox];
    
    //回到登录界面
    FDLoginController *loginVC = [[FDLoginController alloc] init];
    [[UIApplication sharedApplication] keyWindow].rootViewController = loginVC;
}

/**
 *  登录或者注册
 */
- (void)xmppUserConnetToHost:(XMPPRequireResultBlock)requireResultBlock
{
    //保存block
    _requireResultBlock = requireResultBlock;
    
    //断开之前的连接
    [_xmppStream disconnect];
    
    //重新连接
    [self connectToHost];
}

#pragma mark - XMPPStream delegate

/**
 *  与主机连接成功
 */
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    //发送密码,登录或者注册
    [self sendPasswordToHost];
}

/**
 *  与主机断开连接
 */
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    if (error && _requireResultBlock) {
        _requireResultBlock(XMPPRequireResultTypeNetError);
    }
}

/**
 *  授权成功
 */
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    //发送在线消息
    [self sendOnlineToHost];
    
    if (_requireResultBlock) {
        _requireResultBlock(XMPPRequireResultTypeLoginSuccess);
    }
}

/**
 *  授权失败
 */
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    if (_requireResultBlock) {
        _requireResultBlock(XMPPRequireResultTypeLoginFailure);
    }
}

/**
 *  注册成功
 */
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    if (_requireResultBlock) {
        _requireResultBlock(XMPPRequireResultTypeRegisterSuccess);
    }
}

/**
 *  注册失败
 */
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    if (_requireResultBlock) {
        _requireResultBlock(XMPPRequireResultTypeRegisterFailure);
    }
    
    FDLog(@"%@", error);
}

/**
 *  接收到新信息
 */
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSString *msg = [[message elementForName:@"body"] stringValue];
    
    //接收到合法信息，发出通知
    if (msg && from) {
        
        NSString *pattern = [NSString stringWithFormat:@"^[0-9a-zA-Z]+@%@", ServerName];
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
        NSArray *results = [regex matchesInString:from options:0 range:NSMakeRange(0, from.length)];
        NSTextCheckingResult *result = results[0];
        if (!results.count) {
            return;
        }
        
        NSString *jidStr = [from substringWithRange:result.range];
        NSString *account = [jidStr substringWithRange:NSMakeRange(0, jidStr.length-ServerName.length-1)];
        if ((account.length>6) && (account.length<15)) {
            
            NSDictionary *userInfo = @{@"body" : msg,
                                       @"account" : account,
                                       @"jidStr" : jidStr};
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReciveNewMsg object:self userInfo:userInfo];
        }
    }
}

@end
