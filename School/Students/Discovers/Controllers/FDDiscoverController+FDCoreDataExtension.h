//
//  FDDiscoverController+FDCoreDataExtension.h
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverController.h"

@interface FDDiscoverController (FDCoreDataExtension)<NSFetchedResultsControllerDelegate>


@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;   //coredata查询联系人


@end
