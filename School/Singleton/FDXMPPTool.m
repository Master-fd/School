//
//  FDXMPPTool.m
//  School
//
//  Created by asus on 16/3/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDXMPPTool.h"
#import "FDLoginController.h"
#import "FDQResume.h"
#import "FDResume.h"
#import "XMPPvCardTemp.h"

@interface FDXMPPTool()<XMPPStreamDelegate>{
    
    XMPPRequireResultBlock _requireResultBlock;
    XMPPReconnect *_reconnect;
    XMPPvCardCoreDataStorage *_vCardStorage;
    XMPPMessageArchiving *_msgArchiVing;
    
    
}

//标记离线有接受到信息
@property (nonatomic, assign, getter=iSRecord) BOOL record;
//记录离线收到的jidstr信息
@property (nonatomic, strong) NSMutableArray *jidStrs;
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
 *  懒加载
 */
- (NSMutableArray *)jidStrs
{
    if (!_jidStrs) {
        _jidStrs = [NSMutableArray array];
    }
    
    return _jidStrs;
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
    
    //头像模块XMPPvCardAvatarModule
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
    
    //延迟执行，刚开机的时候看看有没有离线消息，有的话就2s后再发通知出来
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.jidStrs.count) {
            for (NSDictionary *dic in self.jidStrs) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReciveNewMsg object:self userInfo:dic];
            }
            [self.jidStrs removeAllObjects];
        }
        self.record = YES;
    });
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
    
    self.record = NO;
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
    
}

/**
 *  接收到新信息,在这里拦截信息，查看是否信息合法，另外查看是否是简历，如果是简历，直接保存
 * 简历的chat字段是"BodyResume"
 */
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSString *msg = [[message elementForName:@"body"] stringValue];
    
    
    //接收到合法简历，保存起来
    if ([msg isEqualToString:kBodyResume]) {
        
        for (XMPPElement *ele in message.children) {
            //取出消息编码,里面保存的是一个FDResume
            if ([ele.name isEqualToString:@"resume"]) {
                
                NSString *base64Str = ele.stringValue;
                NSData *data = [[NSData alloc] initWithBase64EncodedString:base64Str options:0];
                FDResume *resume = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
                [FDQResume insertOneResumeData:resume];
      
            }
        }
    }
    
    //接收到合法聊天信息，发出通知
    if (msg.length && from.length) {
        
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
            //发出通知，让联系人列表显示新消息图标
            
            NSDictionary *userInfo = @{@"body" : msg,
                                       @"account" : account,
                                       @"jidStr" : jidStr};
            if (self.iSRecord) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationReciveNewMsg object:self userInfo:userInfo];
            } else {
                //先记录离线消息，延迟一下在发通知
                [self.jidStrs addObject:userInfo];
            }
            
        }
    }
}


#pragma mark - 公共方法

/**
 *  根据传入的jid号，获取vcard
 */
- (XMPPvCardTemp *)xmppvCardTempForJID:(XMPPJID *)jid shouldFetch:(BOOL)shouldFetch
{
    return [self.vCard vCardTempForJID:jid shouldFetch:shouldFetch];
}

/**
 *  根据传入的jidstr  获取用户vcard,直接联网获取,更新到本地
 */
- (XMPPvCardTemp *)xmppvCardTempForJIDStr:(NSString *)jidStr shouldFetch:(BOOL)shouldFetch
{
    XMPPJID *jid = [XMPPJID jidWithString:jidStr];
    [self.vCard fetchvCardTempForJID:jid ignoreStorage:shouldFetch];  //强制联网获取最新vcard信息
    return [self.vCard vCardTempForJID:jid shouldFetch:shouldFetch];
}
/**
 *  根据传入的jidstr  获取用户vcard,vcard会缓存，有缓存则不联网读取
 */
- (XMPPvCardTemp *)xmppvCardTempForJIDStr:(NSString *)jidStr
{
    XMPPJID *jid = [XMPPJID jidWithString:jidStr];
    return [self.vCard vCardTempForJID:jid shouldFetch:YES];
}
/**
 *  更新用户昵称,自己给用户设置的备注
 */
- (void)xmppUpdateNickname:(NSString *)nickname forUserJidStr:(NSString *)jidStr
{
    XMPPJID *jid = [XMPPJID jidWithString:jidStr];
    [self.roster setNickname:nickname forUser:jid];
}

/**
 *  联网添加好友
 */
- (void)addFriend:(NSString *)account
{
    //判断是否是添加自己
    if ([account isEqualToString:[FDUserInfo shareFDUserInfo].account]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"不能添加自己"];
        });
        
        return;
    }
    
    //判断好友是否存在
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@", account, ServerName];
    XMPPJID *friendJid = [XMPPJID jidWithString:jidStr];
    if ([[FDXMPPTool shareFDXMPPTool].rosterStorage userExistsWithJID:friendJid xmppStream:[FDXMPPTool shareFDXMPPTool].xmppStream]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"好友已存在"];
        });
        
        return;
    }
    
    //发送订阅请求，将nickname设置成默认account
    [[FDXMPPTool shareFDXMPPTool].roster addUser:friendJid withNickname:account];
}
@end
