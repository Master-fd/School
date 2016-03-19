//
//  FDContactsViewController.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseTableViewController.h"


@interface FDBaseContactsController : FDBaseTableViewController

//等待设置数据，只需要给groups赋值，就可以显示， group里面保存FDGroupModel
@property (nonatomic, strong) NSMutableArray *groups;

@end
