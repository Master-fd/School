//
//  FDEditNicknameController.h
//  School
//
//  Created by asus on 16/4/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"

@interface FDEditNicknameController : FDBaseViewController

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign, getter=isOrganization) BOOL organization;
@property (nonatomic, assign, getter=isDepartment) BOOL department;

@end
