//
//  FDResume.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResume.h"
#import "XMPPvCardTemp.h"

@interface FDResume()<NSCoding>

@end

@implementation FDResume


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.jobTitle = [aDecoder decodeObjectForKey:@"jobTitle"];
        self.jobContent = [aDecoder decodeObjectForKey:@"jobContent"];
        self.specialtyOne = [aDecoder decodeObjectForKey:@"specialtyOne"];
        self.specialtyTwo = [aDecoder decodeObjectForKey:@"specialtyTwo"];
        self.jobPurposeOne = [aDecoder decodeObjectForKey:@"jobPurposeOne"];
        self.jobPurposeTwo = [aDecoder decodeObjectForKey:@"jobPurposeTwo"];
        self.Email = [aDecoder decodeObjectForKey:@"Email"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
        self.major = [aDecoder decodeObjectForKey:@"major"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.photo = [aDecoder decodeObjectForKey:@"photo"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.jobTitle forKey:@"jobTitle"];
    [aCoder encodeObject:self.jobContent forKey:@"jobContent"];
    [aCoder encodeObject:self.specialtyOne forKey:@"specialtyOne"];
    [aCoder encodeObject:self.specialtyTwo forKey:@"specialtyTwo"];
    [aCoder encodeObject:self.jobPurposeOne forKey:@"jobPurposeOne"];
    [aCoder encodeObject:self.jobPurposeTwo forKey:@"jobPurposeTwo"];
    [aCoder encodeObject:self.Email forKey:@"Email"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [aCoder encodeObject:self.major forKey:@"major"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    
}



@end
