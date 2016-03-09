//
//  FDNavigationBaseController.m
//  School
//
//  Created by asus on 16/3/5.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDNavigationBaseController.h"

@interface FDNavigationBaseController ()

@end

@implementation FDNavigationBaseController


- (void)viewDidLoad
{
    
}

/**
 *  这个方法只有在第一次使用的时候才被调用
 */
+ (void)initialize
{
    //设置导航栏主题
//    UINavigationBar *navbar = [UINavigationBar appearance];
//    navbar.tintColor = [UIColor whiteColor];
//    navbar.backgroundColor = [UIColor redColor];
//    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    
//    attrs[UITextAttributeFont] = [UIFont systemFontOfSize:14];
//    attrs[UITextAttributeTextColor] = [UIColor whiteColor];
//    [navbar setTitleTextAttributes:attrs];
//    
//    
//    //设置Item主题
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
//    itemAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:14];
//    itemAttrs[UITextAttributeTextColor] = [UIColor whiteColor];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏tabbar
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}
@end
