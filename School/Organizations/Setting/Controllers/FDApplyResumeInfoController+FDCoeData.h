//
//  FDApplyResumeInfoController+FDCoeData.h
//  School
//
//  Created by asus on 16/4/29.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDApplyResumeInfoController.h"

@interface FDApplyResumeInfoController (FDCoeData)<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;

-(void)scrollToBottom:(BOOL)animated;

- (void)loadMoreResume;

@end
