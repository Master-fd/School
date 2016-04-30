//
//  FDResumeSpecialtyCell.h
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDResumeSpecialtyCell : UITableViewCell

@property (nonatomic, strong) UILabel *specialtyOne;

@property (nonatomic, strong) UILabel *specialtyTwo;

/**
 *  是否可编辑
 */
@property (nonatomic, assign, getter=isEditEnable) BOOL editEnable;


@property (nonatomic, copy) void(^infoBlock)();

+ (FDResumeSpecialtyCell *)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)height;




@end
