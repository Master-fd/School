//
//  FDOrganization.h
//  School
//
//  Created by asus on 16/4/27.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FDJobModel;
@interface FDOrganization : NSObject

singleton_interface(FDOrganization);


@property (nonatomic, strong) NSData *photo;

@property (nonatomic, copy) NSString *nickname; //昵称，也就是组织名称

@property (nonatomic, copy) NSString *account;

@property (nonatomic, strong) NSData *QRCode;

@property (nonatomic, strong) NSString *department;  //部门名称

/**
 *  收到的所有简历
 */
@property (nonatomic, strong) NSArray *allResume;

/**
 *  自己发布的jobs 信息,每个元素都是fdjobmodel
 */
@property (nonatomic, strong) NSArray *jobs;
/**
 *  自己的电子名片
 */
@property (nonatomic, strong) XMPPvCardTemp *myVcard;

//添加一条职位信息
- (void)addJobToMyVcard:(FDJobModel *)model;
/**
 *  更新用户vcard信息
 */
- (void)updateMyvCard;

@end
