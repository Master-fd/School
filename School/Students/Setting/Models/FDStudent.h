//
//  FDStudent.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDResume.h"
@class FDResume;

@interface FDStudent : NSObject

//单例
singleton_interface(FDStudent);

@property (nonatomic, strong) NSData *photo;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, strong) NSData *QRCode;

@property (nonatomic, strong) NSDictionary *scores;

@property (nonatomic, strong) FDResume *resume;

/**
 *  电子名片
 */
@property (nonatomic, strong) XMPPvCardTemp *myVcard;

/**
 *  更新用户vcard信息
 */
- (void)updateMyvCard;

//保存简历
- (void)saveResume;

@end
