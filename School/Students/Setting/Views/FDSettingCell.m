//
//  FDSettingCell.m
//  School
//
//  Created by asus on 16/4/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDSettingCell.h"


@implementation FDSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
    }
    
    return _titleLab;
}
- (void)setupViews
{
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    _iconView.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:self.titleLab];
    self.titleLab.alpha = 0.8;
}

- (void)setupContraints
{
    [_iconView autoSetDimensionsToSize:CGSizeMake(34, 34)];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    
    [self.titleLab sizeToFit];
    [self.titleLab autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.titleLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
}
@end
