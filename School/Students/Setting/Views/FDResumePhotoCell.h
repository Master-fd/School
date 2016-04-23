//
//  FDResumePhotoCell.h
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDResumePhotoCell;

@interface FDResumePhotoCell : UITableViewCell

+ (FDResumePhotoCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;

@property (nonatomic, copy) void (^photoBlock)(UIButton *btn);

@property (nonatomic, strong) UIButton *photoBtn;
@end
