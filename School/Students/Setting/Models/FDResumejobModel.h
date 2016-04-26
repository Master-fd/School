//
//  FDResumejobModel.h
//  School
//
//  Created by asus on 16/4/25.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDResumejobModel : NSObject

@property (nonatomic, copy) NSString *jidStr;

@property (nonatomic, copy) NSString *jobName;

@property (nonatomic, copy) NSString *department;

@property (nonatomic, copy) NSString *organization;

@property (nonatomic, strong) NSData *photo;  //组织的头像


/**
 *  字典转模型
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  字典转模型
 */
+ (instancetype)resumeJobWithDict:(NSDictionary *)dict;

@end
