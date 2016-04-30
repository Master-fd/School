//
//  FDOrganization.m
//  School
//
//  Created by asus on 16/4/27.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDOrganization.h"
#import "XMPPvCardTemp.h"
#import "FDJobModel.h"
#import "FDResume.h"


@implementation FDOrganization

singleton_implementation(FDOrganization);

- (NSString *)account
{
    _account = [FDUserInfo shareFDUserInfo].account;
    return _account;
}

- (NSData *)photo
{
    _photo = self.myVcard.photo;
    return _photo;
}
/**
 *  组织名
 */
- (NSString *)nickname
{
    _nickname = self.myVcard.nickname;
    return _nickname;
}

/**
 *  部门名
 */
- (NSString *)department
{
    _department = self.myVcard.familyName;
    return _department;
}
/**
 *  自己vCard获取
 */
- (XMPPvCardTemp *)myVcard
{
    _myVcard = [FDXMPPTool shareFDXMPPTool].vCard.myvCardTemp;
    
    return _myVcard;
}

/**
 *  更新用户vcard信息
 */
- (void)updateMyvCard
{
    [[FDXMPPTool shareFDXMPPTool].vCard updateMyvCardTemp:self.myVcard];
}

//添加一条职位信息
- (void)addJobToMyVcard:(FDJobModel *)model
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.myVcard.jobs];
    [arrayM insertObject:data atIndex:0];
    self.myVcard.jobs = arrayM;
    [self updateMyvCard];
}

/**
 *  懒加载jobs信息
 */
- (NSArray *)jobs
{
    if (!_jobs) {
        _jobs = [NSArray array];
        if (self.myVcard.jobs.count)
        {
            NSMutableArray *arrayM = [[NSMutableArray alloc] init];
            for (NSData *data in self.myVcard.jobs) {
                FDJobModel *model = [[FDJobModel alloc] init];
                model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arrayM addObject:model];
            }
            _jobs = arrayM;
        }
    }else if (self.myVcard.jobs.count != _jobs.count){
        if (self.myVcard.jobs.count)
        {
            NSMutableArray *arrayM = [[NSMutableArray alloc] init];
            for (NSData *data in self.myVcard.jobs) {
                FDJobModel *model = [[FDJobModel alloc] init];
                model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arrayM addObject:model];
            }
            _jobs = arrayM;
        }
    }
    
    return _jobs;
}



@end
