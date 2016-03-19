//
//  FDBaseTableViewController.m
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseTableViewController.h"

@interface FDBaseTableViewController ()

@end

@implementation FDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    self.navigationItem.title = self.navigationController.tabBarItem.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    
}


- (void)logout
{
    [[FDXMPPTool shareFDXMPPTool] xmppUserLogout];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}






@end
