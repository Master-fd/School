//
//  FDChatController.h
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDChatController : UITableViewController

/**
 *  保存FDChatModel 模型，一个模型就是一条信息，文本、图片、声音....
 */
@property (nonatomic, strong) NSMutableArray *messageSources;

@end
