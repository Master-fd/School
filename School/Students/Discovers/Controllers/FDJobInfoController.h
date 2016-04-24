//
//  FDJobInfoController.h
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDJobModel;
@class FDContactModel;
@interface FDJobInfoController : UIViewController

@property (nonatomic, strong) FDJobModel *jobModel;

@property (nonatomic, strong) FDContactModel *contactModel;

@end
