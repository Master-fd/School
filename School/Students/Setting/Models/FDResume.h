//
//  FDResume.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDResume : NSObject


@property (nullable, nonatomic, copy) NSString *jobTitle;

@property (nullable, nonatomic, copy) NSString *jobContent;

@property (nullable, nonatomic, copy) NSString *specialtyOne;

@property (nullable, nonatomic, copy) NSString *specialtyTwo;

@property (nullable, nonatomic, copy) NSString *jobPurposeOne;

@property (nullable, nonatomic, copy) NSString *department;

@property (nullable, nonatomic, copy) NSString *Email;

@property (nullable, nonatomic, copy) NSString *phoneNumber;

@property (nullable, nonatomic, copy) NSString *major;

@property (nullable, nonatomic, copy) NSString *name;

@property (nullable, nonatomic, strong) NSData *photo;
/**
 *  简历主人的jidstr
 */
@property (nullable, nonatomic, copy) NSString *jidStr;


@end
