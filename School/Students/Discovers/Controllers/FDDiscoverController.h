//
//  FDDiscoverController.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseDiscoverController.h"

@interface FDDiscoverController : FDBaseDiscoverController{
    NSFetchedResultsController *_fetchedResultsController;
    
}

@property (nonatomic, strong) NSArray *myOrganizations;   //自己的所有组织好友

@end
