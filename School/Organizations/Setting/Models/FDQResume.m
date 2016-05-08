//
//  FDQResume.m
//  School
//
//  Created by asus on 16/4/29.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQResume.h"
#import "FDQResume+FDCoreDataProperties.h"
#import "NSObject+CoreDataHelper.h"
#import "FDResume.h"



@implementation FDQResume

/**
 *  实体名称，表名称
 */
+(NSString *)entityName
{
    return @"QResume";
}

/**
 *  插入数据
 */
+(FDQResume *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}
/**
 *  删除一条记录
 */
+(void)removeObjectInManagedObjectContext:(NSManagedObjectContext *)context atModel:(FDQResume * __nonnull)model
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];  //查找

    for (FDQResume *mod in results) {
    
        if ([mod.jobTitle isEqualToString:model.jobTitle]
            && [mod.name isEqualToString:model.name]
            && [mod.department isEqualToString:model.department]
            && [mod.major isEqualToString:model
                .major]) {
            
            [context deleteObject:model];  //删除
            break;
        }
    }
    
    
    [self saveContext];
}
/**
 *  update 一条记录的colLect字段
 */
+ (void)updateObjectInManagedObjectContext:(NSManagedObjectContext *)context atModel:(FDQResume *)model withCollect:(BOOL)collect
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];  //查找
    
    for (FDQResume *mod in results) {
        
        if ([mod.jobTitle isEqualToString:model.jobTitle]
            && [mod.name isEqualToString:model.name]
            && [mod.department isEqualToString:model.department]
            && [mod.major isEqualToString:model
                .major]) {
                
                mod.collect = collect;  //修改
                break;
            }
    }
    
    [self saveContext];
}
/**
 *  获取表
 */
+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

/**
 *  统计有多少条记录
 */
+(NSUInteger)count
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [self entityInManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    return [self.managedObjectContext countForFetchRequest:fetchRequest error:nil];
}

/**
 *  插入一条简历
 */
+ (void)insertOneResumeData:(FDResume *)resume
{
    FDQResume *model = [FDQResume insertNewObjectInManagedObjectContext:self.managedObjectContext];
    model.jobTitle = resume.jobTitle;
    model.jobContent = resume.jobContent;
    model.jobPurposeOne = resume.jobPurposeOne;
    model.department = resume.department;
    model.email = resume.Email;
    model.phoneNumber = resume.phoneNumber;
    model.major = resume.major;
    model.name = resume.name;
    model.specialtyOne = resume.specialtyOne;
    model.specialtyTwo = resume.specialtyTwo;
    model.jidStr = resume.jidStr;
    model.photo = resume.photo;
    model.collect = NO;
    
    [self saveContext];
}

@end
