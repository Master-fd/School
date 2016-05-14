//
//  FDApplyResumeInfoController+FDCoeData.m
//  School
//
//  Created by asus on 16/4/29.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDApplyResumeInfoController+FDCoeData.h"
#import "FDQResume.h"
#import "NSObject+CoreDataHelper.h"




@implementation FDApplyResumeInfoController (FDCoeData)



- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
    });
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
    });
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
    });
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView endUpdates];
    });
}
/**
 *  懒加载
 */
- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [FDQResume entityInManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        [fetchRequest setFetchBatchSize:kMaxBachSize];
        [fetchRequest  setFetchLimit:kPageSize];
        
        NSUInteger totalCount = [FDQResume count];//一共多少条记录
        
        [fetchRequest  setFetchOffset:(totalCount>=kPageSize)?(totalCount-kPageSize):0];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"department" ascending:YES];
        
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        aFetchedResultsController.delegate = self;
        _fetchedResultsController = aFetchedResultsController;
        
        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error])
        {
            FDLog(@"错误 %@, %@", error, [error userInfo]);
        }
    }
    
    return _fetchedResultsController;
}
/**
 *  删除所有记录
 */
- (void)removeAllObjectInManagedObjectContext:(NSManagedObjectContext *)context
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [FDQResume entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];  //查找
    
    for (FDQResume *model in results) {
        [context deleteObject:model];  //删除
    }
    
    [self saveContext];
    [self.fetchedResultsController.fetchRequest setFetchOffset:0];  //重置查询请求
}

/**
 *  删除非收藏记录
 */
- (void)removeAllNonCollectObjectInManagedObjectContext:(NSManagedObjectContext *)context withCollect:(BOOL)collect
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [FDQResume entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"collect = %d", collect];
    fetchRequest.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];  //查找
    
    for (FDQResume *model in results) {
        [context deleteObject:model];
    }
    
    [self saveContext];
    
    NSUInteger totalCount = [FDQResume count];//一共多少条记录
    
    [self.fetchedResultsController.fetchRequest  setFetchOffset:(totalCount>=kPageSize)?(totalCount-kPageSize):0]; //重置查询请求
}
/**
 *  滚动到底部
 */
-(void)scrollToBottom:(BOOL)animated
{    //让其滚动到底部
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger section = [[self.fetchedResultsController sections] count];
        if (section >= 1)
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section-1];
            NSInteger row =  [sectionInfo numberOfObjects];
            if (row >= 1)
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section-1] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
            }
        }
    });
}

/**
 *  加载更多
 */
-(void)loadMoreResume
{
    
    NSFetchRequest *fetchRequest = self.fetchedResultsController.fetchRequest;
    NSUInteger offset = fetchRequest.fetchOffset;
    NSUInteger limit;
    NSUInteger newRows;//新增了多少条数据?
    
    if (offset>=kPageSize)
    {//可以加载前10条数据
        offset -= kPageSize;
        newRows = kPageSize;
        limit  =  [self.tableView numberOfRowsInSection:0] + newRows;
    }else
    {//前面不够一页，就显示所有数据
        newRows = offset;
        offset  = 0;
        limit   = 0;
    }
    
    [fetchRequest setFetchOffset:offset];
    [fetchRequest  setFetchLimit:limit];
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error])
    {//再次执行查询请求
        FDLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else
    {
        if (newRows)
        {
            NSMutableArray *insertRows = [NSMutableArray arrayWithCapacity:newRows];
            for (NSUInteger i =0; i<newRows; i++)
            {
                [insertRows addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:insertRows withRowAnimation:UITableViewRowAnimationNone];//如何避免一闪?
            [self.tableView endUpdates];
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"已经没有更多简历了"];
            });
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [self.refreshControl endRefreshing];
                       
        if (newRows)
        {  //滚动到底部
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newRows inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
                       
    });
    
}

@end
