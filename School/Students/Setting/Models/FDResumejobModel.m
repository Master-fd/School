//
//  FDResumejobModel.m
//  School
//  已应聘工作模型
//  Created by asus on 16/4/25.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumejobModel.h"

@implementation FDResumejobModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)resumeJobWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
