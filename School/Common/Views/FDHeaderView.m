//
//  FDHeaderView.m
//  School
//
//  Created by asus on 16/8/10.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDHeaderView.h"

@interface FDHeaderView()

@property (nonatomic, strong) UILabel *nameLab;

@end
@implementation FDHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.nameLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLab];
        
        self.nameLab.backgroundColor = [UIColor clearColor];
        self.nameLab.textColor = [UIColor grayColor];
        self.nameLab.alpha = 0.9;
        self.nameLab.font = [UIFont systemFontOfSize:14];
        [self.nameLab sizeToFit];
        [self.nameLab autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 0) excludingEdge:ALEdgeRight];
        
    }
    

    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.nameLab.text = title;
    
}
@end
