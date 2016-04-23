//
//  FDDiscoverCell.m
//  School
//
//  Created by asus on 16/4/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDiscoverCell.h"


@implementation FDDiscoverCell

+ (instancetype)discoverCellWithTableView:(UITableView *)tableview
{
    NSString * const cellId = @"discoverCell";
    
    FDDiscoverCell *cell = [tableview dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[FDDiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加控件
        [self setupViews];
        //添加约束
        [self setupContraints];
        
    }
    
    return self;
}

- (void)setupViews
{
    
}

- (void)setupContraints
{
    
}


@end
