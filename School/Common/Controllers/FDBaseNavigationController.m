//
//  FDBaseNavigationController.m
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseNavigationController.h"

@interface FDBaseNavigationController ()

@end

@implementation FDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

/**
 *  初始化执行一次
 */
+ (void)initialize
{
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    [super pushViewController:viewController animated:animated];
    
}
@end
