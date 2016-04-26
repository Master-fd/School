//
//  FDJobModel.m
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDJobModel.h"

@interface FDJobModel()<NSCoding>

@end


@implementation FDJobModel




- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.jobName forKey:@"jobName"];
    [aCoder encodeObject:self.jobDescribe forKey:@"jobDescribe"];
    [aCoder encodeObject:self.jobCount forKey:@"jobCount"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.organization forKey:@"organization"];
    [aCoder encodeObject:self.department forKey:@"department"];
    [aCoder encodeObject:self.jobHarvest forKey:@"jobHarvest"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.jobName = [aDecoder decodeObjectForKey:@"jobName"];
        self.jobDescribe = [aDecoder decodeObjectForKey:@"jobDescribe"];
        self.jobCount = [aDecoder decodeObjectForKey:@"jobCount"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.organization = [aDecoder decodeObjectForKey:@"organization"];
        self.department = [aDecoder decodeObjectForKey:@"department"];
        self.jobHarvest = [aDecoder decodeObjectForKey:@"jobHarvest"];
    }
    
    return self;
}


@end
