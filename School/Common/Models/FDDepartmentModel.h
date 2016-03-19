//
//  FDDepartmentModel.h
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDDepartmentModel : NSObject

@property (nonatomic, copy) NSString *account;        //账号
@property (nonatomic, copy) NSString *departmentName;    //部门名称
@property (nonatomic, strong) NSData *QRCode;             //二维码
@end
