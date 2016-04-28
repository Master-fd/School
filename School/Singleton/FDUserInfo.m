//
//  FDUserInfo.m
//  School
//
//  Created by asus on 16/3/9.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDUserInfo.h"

//用户账户密码plist路径
#define userPlistPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userPlist.plist"]

//用户信息保存在plist中的键值
#define accountKey       @"accountKey"
#define passwordKey      @"passwordKey"
#define registerAccountKey       @"registerAccountKey"
#define registerPasswordKey      @"registerPasswordKey"
#define loginStatusKey      @"loginStatusKey"
#define organizationKey      @"organizationKey"

@implementation FDUserInfo

//单例
singleton_implementation(FDUserInfo);


/**
 *  从沙盒中获取用户信息
 */
- (void)readUserInfoFromSabox
{

    NSDictionary *userInfo = [NSDictionary dictionaryWithContentsOfFile:userPlistPath];
    
    self.account = [userInfo objectForKey:accountKey];
    self.password = [userInfo objectForKey:passwordKey];
    self.loginStatus = [[userInfo objectForKey:loginStatusKey] boolValue];
    self.organizationFlag = [[userInfo objectForKey:organizationKey] boolValue];
}

/**
 *  将用户信息写入沙盒中
 */
- (void)writeUserInfoToSabox
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    if (self.account) {
        [userInfo setObject:self.account forKey:accountKey];
    }
    if (self.password) {
        [userInfo setObject:self.password forKey:passwordKey];
    }
    if (self.loginStatus) {
        [userInfo setObject:[NSNumber numberWithBool:self.loginStatus] forKey:loginStatusKey];
    }
    if (self.organizationFlag) {
        [userInfo setObject:[NSNumber numberWithBool:self.organizationFlag] forKey:organizationKey];
    }
    
    [userInfo writeToFile:userPlistPath atomically:YES];
    
}

- (NSString *)jidStr
{
    _jidStr = [NSString stringWithFormat:@"%@@%@", self.account, ServerName];
    
    return _jidStr;
}




@end
