//
//  FDContactViewCell.h
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FDContactModel;
#define   cellId   @"cellId"
@interface FDContactViewCell : UITableViewCell

//contactModel 赋值，既可以显示好友头像，账号等信息
@property (nonatomic, strong) FDContactModel *contactModel;


//新建一个重用cell
+ (instancetype)contactViewCellWithTableView:(UITableView *)tableview;
@end
