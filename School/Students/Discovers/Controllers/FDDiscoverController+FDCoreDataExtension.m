//
//  FDDiscoverController+FDCoreDataExtension.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverController+FDCoreDataExtension.h"
#import "FDContactModel.h"

#define kFetchBatchSize   20   //每次从数据库中最多取20条
#define kFetchLimit       10   //每页10条

#define kEntity         @"XMPPUserCoreDataStorageObject"



@implementation FDDiscoverController (FDCoreDataExtension)


#pragma mark - NSFetchedResultsController

//查询的是所有的好友FDContactModel，然后筛选出组织账户,myOrganizations只是保存了组织的FDContactModel模型，内存不大
- (NSFetchedResultsController *)fetchedResultsController
{
    static NSManagedObjectContext *context;
    static NSFetchRequest *request;
    //关联上下文
    if (!_fetchedResultsController) {
        
        //关联上下文
        context = [FDXMPPTool shareFDXMPPTool].rosterStorage.mainThreadManagedObjectContext;
        
        //设置查询条件
        NSString *jidStr = [FDUserInfo alloc].jidStr;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = % @AND subscription != %@", jidStr, @"none"];  //自己的账号
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];  //使用displayName作为排序依据
        
        //关联表XMPPUserCoreDataStorageObject
        request = [[NSFetchRequest alloc] initWithEntityName:kEntity];
        request.sortDescriptors = @[sort];
        request.predicate = predicate;
        
        [request setFetchOffset:0];
        
    }
    //开始查询
    NSError *error = nil;
    NSArray *dataSource = [context executeFetchRequest:request error:&error];
    if (error) {
        FDLog(@"%@", error);
    }else{
        [self getMyOrganizations:dataSource];  //将属于自己的  是组织的联系人过滤出来,保存到myOrganizations
    }
    
    
    return _fetchedResultsController;
    
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
