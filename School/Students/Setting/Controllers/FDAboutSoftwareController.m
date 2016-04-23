//
//  FDAboutSoftwareController.m
//  School
//
//  Created by asus on 16/4/18.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDAboutSoftwareController.h"

@interface FDAboutSoftwareController (){
    
    UIImageView *_imageView;
    UILabel *_descLable;
}

@end

@implementation FDAboutSoftwareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
    
}

- (void)setupViews
{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutSchool"]];
    [self.view addSubview:_imageView];
    _imageView.backgroundColor = [UIColor clearColor];
    
    _descLable = [[UILabel alloc] init];
    [self.view addSubview:_descLable];
    _descLable.text = @"School 1.1";
    _descLable.alpha = 0.8;
    _descLable.textColor = [UIColor grayColor];
    _descLable.textAlignment = NSTextAlignmentCenter;
    _descLable.font = [UIFont systemFontOfSize:20];
    _descLable.backgroundColor = [UIColor clearColor];
}

- (void)setupContraints
{
    [_imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64];
    [_imageView autoSetDimensionsToSize:CGSizeMake(144, 100)];
    
    [_descLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_descLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView withOffset:10];
    [_descLable sizeToFit];
    
}
@end
