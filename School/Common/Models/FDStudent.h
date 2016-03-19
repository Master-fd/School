//
//  FDStudent.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDResume;
@interface FDStudent : NSObject

@property (nonatomic, strong) NSData *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, assign, getter=isSex) BOOL sex;

@property (nonatomic, strong) NSData *QRCode;

@property (nonatomic, strong) NSDictionary *scores;

@property (nonatomic, strong) FDResume *resume;

@end
