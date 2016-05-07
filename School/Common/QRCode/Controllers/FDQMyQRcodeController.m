//
//  FDQMyQRcodeController.m
//  School
//
//  Created by asus on 16/5/6.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQMyQRcodeController.h"
#import "FDQRCode.h"
#import "FDOrganization.h"
#import "FDUserInfo.h"
#import "XMPPvCardTemp.h"


@interface FDQMyQRcodeController (){
    
    UIImageView *_myRQCode;
}

@end

@implementation FDQMyQRcodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
}

- (void)setupViews
{
    CGSize size = CGSizeMake(200, 200);
    
    _myRQCode  = [[UIImageView alloc] init];
    [self.view addSubview:_myRQCode];
    
    _myRQCode.size = size;
    
    if ([FDOrganization shareFDOrganization].QRCode.length) {
        
        _myRQCode.image = [UIImage imageWithData:[FDOrganization shareFDOrganization].QRCode];
    }else{
        //传入账户，创建二维码
        UIImage *image = [FDQRCode createQRCodeWithString:[FDOrganization shareFDOrganization].account atSize:size];
        _myRQCode.image = image;
        
        //保存
        [FDOrganization shareFDOrganization].myVcard.sound = UIImageJPEGRepresentation(image, 1.0);
        [[FDOrganization shareFDOrganization] updateMyvCard];
    }
}
/**
 *  添加约束
 */
- (void)setupContraints
{
    
    [_myRQCode autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [_myRQCode autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view];
    
}
@end
