//
//  FDResumePhotoCell.m
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumePhotoCell.h"


#define kCellHeight     100

@interface FDResumePhotoCell()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIView *_bgView;
    UILabel *_titleLab;

}


@end
@implementation FDResumePhotoCell



+ (FDResumePhotoCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * const CellId = @"photoCell";
    FDResumePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    _bgView.layer.cornerRadius = 5;
    _bgView.layer.masksToBounds = YES;
    
    _photoBtn = [[UIButton alloc] init];
    [_photoBtn setBackgroundColor:[UIColor clearColor]];
    [_bgView addSubview:_photoBtn];
    [_photoBtn setBackgroundImage:[UIImage imageNamed:@"icon_headimge_placeholder"] forState:UIControlStateNormal];
    [_photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchDown];

    _titleLab = [[UILabel alloc] init];
    [_bgView addSubview:_titleLab];
    _titleLab.text = @"点击更换";
    _titleLab.textColor = [UIColor grayColor];
    _titleLab.alpha = 0.7;
    _titleLab.font = [UIFont systemFontOfSize:14];
}


- (void)setupContraints
{
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 16, 0, 16)];

    [_titleLab sizeToFit];
    [_titleLab autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_titleLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6];

    [_photoBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_photoBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_photoBtn autoSetDimensionsToSize:CGSizeMake(60, 60)];
    
    
}
#pragma mark - 公共方法

- (void)setEditEnable:(BOOL)editEnable
{
    if (editEnable) {
        _titleLab.hidden = NO;
    }else{
        _titleLab.hidden = YES;
    }
}
//photoclick
- (void)photoBtnClick
{
    if (self.photoBlock) {
        self.photoBlock(_photoBtn);
    }
    
}




//设置固有高度
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kCellHeight);
}

+ (CGFloat)height
{
    return kCellHeight;
}
@end
