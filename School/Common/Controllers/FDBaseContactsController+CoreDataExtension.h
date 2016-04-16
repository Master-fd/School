//
//  FDBaseContactsController+CoreDataExtension.h
//  School
//
//  Created by asus on 16/4/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseContactsController.h"

@interface FDBaseContactsController (CoreDataExtension)<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;
@end
