//
//  FDBaseLoginController.m
//  School
//  执行登录或者注册联网操作，跳转页面控制器
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseLoginController.h"
#import "FDBaseNavigationController.h"
//学生端
#import "FDMessageController.h"
#import "FDContactController.h"
#import "FDDiscoverController.h"
#import "FDSettingController.h"

//组织端

@interface FDBaseLoginController ()

@end

@implementation FDBaseLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)UserConnetToHost
{
    
    [[FDXMPPTool shareFDXMPPTool] xmppUserConnetToHost:^(XMPPRequireResultType type) {
        dispatch_sync(dispatch_get_main_queue(), ^{  //同步线程，阻塞在这里
            if ([FDXMPPTool shareFDXMPPTool].isRegisterOperation) {
                [FDMBProgressHUB showMessage:@"正在注册..."];
            }else{
                [FDMBProgressHUB showMessage:@"正在登录..."];
            }
        });
        [FDMBProgressHUB hideHUD];
        [self xmppUserConnetResult:type];
    }];

}


/**
 *  连接host之后返回的结果，下一步处理
 */
+ (void)xmppUserConnetResult:(XMPPRequireResultType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (type) {
            case XMPPRequireResultTypeLoginFailure:
                [FDMBProgressHUB showError:@"登录失败"];
                //提示是否IP没有设置正确
                break;
            case XMPPRequireResultTypeLoginSuccess:
                [FDMBProgressHUB showSuccess:@"登录成功"];
                //跳转页面
                [self enterStudentClientMainPage];  //学生端
                break;
            case XMPPRequireResultTypeRegisterFailure:
                [FDMBProgressHUB showError:@"注册失败,账户已被使用"];
                break;
            case XMPPRequireResultTypeRegisterSuccess:
                [FDMBProgressHUB showSuccess:@"注册成功"];
                break;
            case XMPPRequireResultTypeNetError:
                [FDMBProgressHUB showError:@"连接失败"];
                break;
            default:
                break;
        }
    });
}

/**
 *  主界面
 */
+ (void)enterStudentClientMainPage
{
    //保存该用户已经登录过,只要能进来主界面，说明就是登录过了
    [FDUserInfo shareFDUserInfo].loginStatus = YES;
    [[FDUserInfo shareFDUserInfo] writeUserInfoToSabox];
    
    FDContactController *organizationsVC = [[FDContactController alloc] initWithStyle:UITableViewStyleGrouped];
    FDBaseNavigationController *organizationsNav  = [[FDBaseNavigationController alloc] initWithRootViewController:organizationsVC];
    FDDiscoverController *discoversVC = [[FDDiscoverController alloc] initWithStyle:UITableViewStyleGrouped];
    FDBaseNavigationController *discoversNav  = [[FDBaseNavigationController alloc] initWithRootViewController:discoversVC];
    FDSettingController *settingVC = [[FDSettingController alloc] initWithStyle:UITableViewStyleGrouped];
    FDBaseNavigationController *settingNav  = [[FDBaseNavigationController alloc] initWithRootViewController:settingVC];
    
    
    //获取主窗口
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    
    [tabbarVc addChildViewController:organizationsNav];
    [tabbarVc addChildViewController:discoversNav];
    [tabbarVc addChildViewController:settingNav];
    //
    organizationsNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联系人" image:[UIImage imageNamed:@"tabbar_contacts"] selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    discoversNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    settingNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"tabbar_me"] selectedImage:[UIImage imageNamed:@"tabbar_meHL"]];

    
    window.rootViewController = tabbarVc;
    
    
    
}
@end
