//
//  FDBaseViewController.m
//  School
//
//  Created by asus on 16/4/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"

@interface FDBaseViewController ()

@end

@implementation FDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

/**
 *  设置统一viewcontrol主题
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = kBaseViewControlBackColor;
    }
    return self;
}


@end
