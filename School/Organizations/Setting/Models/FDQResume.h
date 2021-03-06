//
//  FDQResume.h
//  School
//
//  Created by asus on 16/4/29.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  是否执行过删除所有或者删除非收藏的操作
 */

@class FDResume;
@interface FDQResume : NSManagedObject


/**
 *  表名称
 */
+(NSString*)entityName;

/**
 *  插入一条记录
 */
+(FDQResume *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  通过索引，删除一条记录
 */
+(void)removeObjectInManagedObjectContext:(NSManagedObjectContext *)context atModel:(FDQResume *)model;

/**
 *  插入一条简历到数据库
 */
+ (void)insertOneResumeData:(FDResume *)resume;

/**
 *  update 一条记录的colLect字段
 */
+ (void)updateObjectInManagedObjectContext:(NSManagedObjectContext *)context atModel:(FDQResume *)model withCollect:(BOOL)collect;

/**
 *  获取表
 */
+(NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)context;

/**
 *  查询总记录
 */
+(NSUInteger)count;




@end

NS_ASSUME_NONNULL_END
