//
//  FDResumeInfoCell.m
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeInfoCell.h"

@interface FDResumeInfoCell(){
    
}

@end


@implementation FDResumeInfoCell

+ (FDResumeInfoCell *)cellForTableView:(UITableView *)tableView;
{
    NSString * const CellId = @"Cell";
    FDResumeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumeInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
        
    }
    
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    }


- (void)setupContraints
{
    
    
}



@end
