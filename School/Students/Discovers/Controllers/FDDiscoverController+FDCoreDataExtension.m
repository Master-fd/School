//
//  FDDiscoverController+FDCoreDataExtension.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverController+FDCoreDataExtension.h"
#import "FDContactModel.h"

@implementation FDDiscoverController (FDCoreDataExtension)


#pragma mark - NSFetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        
        //关联上下文
        NSManagedObjectContext *context = [FDXMPPTool shareFDXMPPTool].rosterStorage.mainThreadManagedObjectContext;
        
        //设置查询条件
        NSString *jidStr = [FDUserInfo alloc].jidStr;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@", jidStr];  //自己的账号
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];  //使用displayName作为查询依据
        
        //关联表XMPPUserCoreDataStorageObject
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"XMPPUserCoreDataStorageObject"];
        request.sortDescriptors = @[sort];
        request.predicate = predicate;
        
        //开始查询
        NSError *error = nil;
        NSArray *dataSource = [context executeFetchRequest:request error:&error];
        if (error) {
            FDLog(@"%@", error);
        }else{
            [self getMyOrganizations:dataSource];  //将属于自己的  是组织的联系人过滤出来,保存到myOrganizations
        }
        
        //查询数据变化
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        
        
        if ([_fetchedResultsController performFetch:&error]) {
            FDLog(@"%@", error);
        }
    }
    
    return _fetchedResultsController;
    
}


#pragma mark - NSFetchedResultsController delegate

//数据已经发生改变
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self getMyOrganizations:self.fetchedResultsController.fetchedObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData]; // 刷新tableview
    });
    
    FDLog(@"更新招聘信息");
}

/**
 *  判断是否是合理的数据,获取组织的联系人模型保存到myOrganizations
 */
- (void)getMyOrganizations:(NSArray *)dataSource
{
    NSArray *results;
    NSMutableArray *myOrganizations = [NSMutableArray array];
    NSString *pattern = @"^[a-zA-Z]";
    
    for (FDContactModel *model in dataSource) {
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
        //遍历所有好友，查询jidstr，以字母开头的就是组织
        results = [regex matchesInString:model.jidStr options:0 range:NSMakeRange(0, model.jidStr.length)];
        if (results.count) {  //是组织,保存这个联系人模型
            [myOrganizations addObject:model];
        }
    }
    self.myOrganizations = myOrganizations; // 保存数据
    
}
@end
