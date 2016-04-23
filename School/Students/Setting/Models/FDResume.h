//
//  FDResume.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDResume : NSObject


@property (nonatomic, copy) NSString *jobTitle;

@property (nonatomic, copy) NSString *jobContent;

@property (nonatomic, copy) NSString *specialtyOne;

@property (nonatomic, copy) NSString *specialtyTwo;

@property (nonatomic, copy) NSString *jobPurposeOne;

@property (nonatomic, copy) NSString *jobPurposeTwo;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSData *photo;


@end
