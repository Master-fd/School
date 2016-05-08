//
//  FDContactsViewController.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FDBaseContactsController : UITableViewController{
    
    NSFetchedResultsController *_fetchedResultsController;
}

/**
 *  删除指定人的聊天记录
 */
- (void)deleteRecordDataInJidStr:(NSString *)jidStr;


@end
