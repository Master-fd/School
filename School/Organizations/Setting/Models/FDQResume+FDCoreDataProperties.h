//
//  FDQResume+FDCoreDataProperties.h
//  School
//
//  Created by asus on 16/4/30.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQResume.h"


NS_ASSUME_NONNULL_BEGIN

@interface FDQResume (FDCoreDataProperties)



@property (nullable, nonatomic, copy) NSString *jobTitle;

@property (nullable, nonatomic, copy) NSString *jobContent;

@property (nullable, nonatomic, copy) NSString *specialtyOne;

@property (nullable, nonatomic, copy) NSString *specialtyTwo;

@property (nullable, nonatomic, copy) NSString *jobPurposeOne;

@property (nullable, nonatomic, copy) NSString *department;

@property (nullable, nonatomic, copy) NSString *email;

@property (nullable, nonatomic, copy) NSString *phoneNumber;

@property (nullable, nonatomic, copy) NSString *major;

@property (nullable, nonatomic, copy) NSString *name;

@property (nullable, nonatomic, strong) NSData *photo;


/**
 *  简历主人的jidstr
 */
@property (nullable, nonatomic, copy) NSString *jidStr;

/**
 *  是否收藏,这个字段是需要组织自己修改的
 */
@property (nonatomic, assign) BOOL collect;
@end

NS_ASSUME_NONNULL_END

