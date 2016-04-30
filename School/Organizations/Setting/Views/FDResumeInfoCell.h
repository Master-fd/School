//
//  FDResumeInfoCell.h
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDQResume;
@interface FDResumeInfoCell : UITableViewCell

@property (nonatomic, strong) FDQResume *model;

@property (nonatomic, copy) NSString *department;

+ (FDResumeInfoCell *)cellForTableView:(UITableView *)tableView;

@end
