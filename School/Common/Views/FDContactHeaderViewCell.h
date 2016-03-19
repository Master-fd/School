//
//  FDContactHeaderViewCell.h
//  School
//
//  Created by asus on 16/3/14.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDGroupModel;
@class FDContactHeaderViewCell;

@protocol FDContactHeaderViewCellDelegate <NSObject>

- (void)groupHeaderViewDidClickButton:(FDContactHeaderViewCell *)groupHeaderViewCell;

@end

@interface FDContactHeaderViewCell : UITableViewHeaderFooterView

//给groupModel模型赋值，既可以显示，里面组名,在线人数
@property (nonatomic, strong) FDGroupModel *groupModel;

//生成一个重用header cell
+ (instancetype)contactHeaderViewCellWithTableView:(UITableView *)tableview;

//按键代理
@property (nonatomic, weak) id<FDContactHeaderViewCellDelegate> delegate;

@end
