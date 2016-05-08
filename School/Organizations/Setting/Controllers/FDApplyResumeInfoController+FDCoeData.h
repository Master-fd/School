//
//  FDApplyResumeInfoController+FDCoeData.h
//  School
//
//  Created by asus on 16/4/29.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDApplyResumeInfoController.h"


#define kMaxBachSize      (20)    //每次最多从数据库读取20条数据
#define kPageSize         (10)    //一页10条数据

@interface FDApplyResumeInfoController (FDCoeData)<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;

/**
 *  滚动到底部
 */
-(void)scrollToBottom:(BOOL)animated;


/**
 *  加载更多数据
 */
- (void)loadMoreResume;

/**
 *  删除非收藏记录
 */
- (void)removeAllNonCollectObjectInManagedObjectContext:(NSManagedObjectContext *)context withCollect:(BOOL)collect;
/**
 *  删除所有记录
 */
- (void)removeAllObjectInManagedObjectContext:(NSManagedObjectContext *)context;

@end
