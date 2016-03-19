//
//  FDJobModel.h
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDJobModel : NSObject

@property (nonatomic, copy) NSString *jobRequire;
@property (nonatomic, copy) NSString *jobContent;
@property (nonatomic, assign) int *jobCount;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *jobName;

@end
