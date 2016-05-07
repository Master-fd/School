//
//  FDChatController+FDCoreDateExtension.m
//  School
//
//  Created by asus on 16/4/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatController+FDCoreDateExtension.h"

//实体表名称
#define kEntity     @"XMPPMessageArchiving_Message_CoreDataObject"
@implementation FDChatController (FDCoreDateExtension)



- (NSUInteger)numberOfDataInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:kEntity inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    return [context countForFetchRequest:fetchRequest error:nil];
}

/**
 *  懒加载
 */
- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
         
        //关联上下文
        NSManagedObjectContext *context = [FDXMPPTool shareFDXMPPTool].msgStorage.mainThreadManagedObjectContext;
        
        //设置查询条件
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@", [FDUserInfo alloc].jidStr, self.jidStr];
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
        
        //关联表XMPPUserCoreDataStorageObject
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kEntity];
        request.sortDescriptors = @[sort];
        request.predicate = predicate;
        
        
        NSUInteger totalCount = [self numberOfDataInContext:context];//一共多少条记录
        [request  setFetchOffset:(totalCount>=10)?(totalCount-10):0];
        [request setFetchBatchSize:30];
        [request setFetchLimit:10];
        
        //开始查询
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if ([_fetchedResultsController performFetch:&error]) {
            FDLog(@"%@", error);
        }
    }
    
    return _fetchedResultsController;
    
}

#pragma mark - NSFetchedResultsController delegate

/**
 *  开始更新数据
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
    });
}

/**
 *  更新section
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    dispatch_async(dispatch_get_main_queue(), ^{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
    });
}

/**
 *  更新row
 */
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

/**
 *  数据更新完毕
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView endUpdates];
    });
    [self scrollToBottom:YES];
}

@end
