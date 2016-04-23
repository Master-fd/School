//
//  FDResumePurposeCell.h
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDResumePurposeCell : UITableViewCell

@property (nonatomic, strong) UILabel *purposeOne;

@property (nonatomic, strong) UILabel *purposeTwo;

@property (nonatomic, copy) void(^infoBlock)();

+ (FDResumePurposeCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;

@end
