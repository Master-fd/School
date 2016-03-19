//
//  FDContactModel.m
//  School
//
//  Created by asus on 16/3/12.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDOrganizationModel.h"

@implementation FDOrganizationModel

- (NSMutableArray *)departments
{
    if (!_departments) {
        _departments = [NSMutableArray array];
    }
    
    return _departments;
}

- (NSMutableArray *)jobs
{
    if (_jobs) {
        _jobs = [NSMutableArray array];
    }
    
    return _jobs;
}

@end
