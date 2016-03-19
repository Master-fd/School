//
//  FDResume.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDResume : NSObject

@property (nonatomic, copy) NSString *experience;

@property (nonatomic, copy) NSString *adept;

@property (nonatomic, copy) NSString *jobPurpose;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *college;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSData *icon;

@property (nonatomic, assign) int *age;

@property (nonatomic, assign, getter=isSex) BOOL *sex;


@end
