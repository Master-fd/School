//
//  FDBaseNavigationController.m
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseNavigationController.h"

#define    kNavColor       [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.8]
@interface FDBaseNavigationController ()

@end

@implementation FDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

/**
 *  初始化执行一次,在这里修改导航栏主题
 */
+ (void)initialize
{
    //设置导航栏背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = kNavColor; // 设置返回键的小图标颜色
//    [navBar setBackgroundColor:[UIColor grayColor]];
    
    //设置标题
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
    //titleAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    titleAttrs[NSForegroundColorAttributeName] = kNavColor;
    [navBar setTitleTextAttributes:titleAttrs];
    
    //设置item主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    itemAttrs[NSForegroundColorAttributeName] = kNavColor;
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    
}

@end
