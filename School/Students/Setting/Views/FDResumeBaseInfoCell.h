//
//  FDResumeBaseInfoCell.h
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDResumeBaseInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *major;
@property (nonatomic, strong) UILabel *phoneNumber;
@property (nonatomic, strong) UILabel *email;

@property (nonatomic, copy) void(^infoBlock)();

+ (FDResumeBaseInfoCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;


@end
