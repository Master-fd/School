//
//  FDContactModel.h
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDDepartmentModel.h"
#import "FDJobModel.h"

@interface FDOrganizationModel : NSObject

@property (nonatomic, strong) NSData *organizationIcon;            //头像
@property (nonatomic, copy) NSString *organizationName;        //组织名
@property (nonatomic, copy) NSString *describe;         //简介
@property (nonatomic, strong) NSMutableArray *departments;        //部门
@property (nonatomic, strong) NSMutableArray *jobs;    //工作
@property (nonatomic, strong) NSData *QRCode;      //二维码

@end
