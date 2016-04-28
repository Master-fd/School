//
//  FDBaseContactsController+CoreDataExtension.m
//  School
//
//  Created by asus on 16/4/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseContactsController+CoreDataExtension.h"


@implementation FDBaseContactsController (CoreDataExtension)

/**
 *  懒加载
 */
- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        
        //关联上下文
        NSManagedObjectContext *context = [FDXMPPTool shareFDXMPPTool].rosterStorage.mainThreadManagedObjectContext;
        
        //设置查询条件
        NSString *jidStr = [FDUserInfo shareFDUserInfo].jidStr;
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@", jidStr];
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
        
        //关联表XMPPUserCoreDataStorageObject
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"XMPPUserCoreDataStorageObject"];
        request.sortDescriptors = @[sort];
        request.predicate = predicate;
        
        //开始查询
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:@"displayName" cacheName:nil];   //使用displayName作为section分组依据
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
    [self.tableView beginUpdates];
}

/**
 *  更新section
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
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
}

/**
 *  更新row
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
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
}

/**
 *  数据更新完毕
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
@end
