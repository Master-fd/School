//
//  FDTestViewController.m
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDTestViewController.h"
#import "NSString+FDExtension.h"

@interface FDTestViewController ()

@property (nonatomic, strong) UILabel *lable;
@end

@implementation FDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [self.view addSubview:self.lable];
    self.lable.text = @"飞zhu";
    
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btnClick
{
    FDLog(@"%@", [NSString capitalizedWithFristCharactor:self.lable.text]);
}

@end
