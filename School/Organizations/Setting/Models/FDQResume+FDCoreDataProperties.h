//
//  FDQResume+FDCoreDataProperties.h
//  School
//
//  Created by asus on 16/4/30.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQResume.h"



@interface FDQResume (FDCoreDataProperties)

@property (nonatomic, copy) NSString *jobTitle;

@property (nonatomic, copy) NSString *jobContent;

@property (nonatomic, copy) NSString *specialtyOne;

@property (nonatomic, copy) NSString *specialtyTwo;

@property (nonatomic, copy) NSString *jobPurposeOne;

@property (nonatomic, copy) NSString *jobPurposeTwo;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *major;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSData *photo;

/**
 *  部门
 */
@property (nullable, nonatomic, copy) NSString *department;

/**
 *  是否收藏
 */
@property (nonatomic, assign) BOOL collect;


@end


