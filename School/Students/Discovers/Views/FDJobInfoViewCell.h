//
//  FDJobInfoView.h
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDJobModel;
@interface FDJobInfoViewCell : UITableViewCell


@property (nonatomic, strong) FDJobModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;
+ (CGFloat)height;
@end
