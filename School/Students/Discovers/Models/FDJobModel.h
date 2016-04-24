//
//  FDJobModel.h
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDJobModel : NSObject

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *jobDescribe;   //职位描述

@property (nonatomic, copy) NSString *jobCount;

@property (nonatomic, copy) NSData *icon;

@property (nonatomic, copy) NSString *organization;

@property (nonatomic, copy) NSString *department;

@property (nonatomic, copy) NSString *jobHarvest;   //职位诱惑

@end
