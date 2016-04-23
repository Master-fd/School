//
//  FDChatController.h
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseViewController.h"

@interface FDChatController : FDBaseViewController{
    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, strong) UITableView *tableView;

/**
 *  好友jidstr
 */
@property (nonatomic, copy) NSString *jidStr;


/**
 *  滚动到底部
 */
-(void)scrollToBottom:(BOOL)animated;
@end
