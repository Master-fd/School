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
#define loginStatusKey      @"loginStatusKey"

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
    
}

/**
 *  将用户信息写入沙盒中
 */
- (void)writeUserInfoToSabox
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    
    [userInfo setObject:self.account forKey:accountKey];
    [userInfo setObject:self.password forKey:passwordKey];
    [userInfo setObject:[NSNumber numberWithBool:self.loginStatus] forKey:loginStatusKey];
    [userInfo writeToFile:userPlistPath atomically:YES];
}
@end