//
//  FDResumeExperienceCell.h
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDResumeExperienceCell : UITableViewCell


@property (nonatomic, strong) UITextView *jobContent;
@property (nonatomic, strong) UILabel *jobTitle;

@property (nonatomic, copy) void(^infoBlock)();

+ (FDResumeExperienceCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;

@end
