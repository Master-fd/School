//
//  FDMyQRCodeController.m
//  School
//  我的二维码
//  Created by asus on 16/5/6.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMyQRCodeController.h"
#import "FDQRCode.h"
#import "FDStudent.h"
#import "FDUserInfo.h"
#import "XMPPvCardTemp.h"



@interface FDMyQRCodeController (){
    
    UIImageView *_myRQCode;
}

@end

@implementation FDMyQRCodeController

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
    
    if ([FDStudent shareFDStudent].QRCode.length) {
        
        _myRQCode.image = [UIImage imageWithData:[FDStudent shareFDStudent].QRCode];
    }else{
        //传入账户，创建二维码
        UIImage *image = [FDQRCode createQRCodeWithString:[FDStudent shareFDStudent].account atSize:size];
        _myRQCode.image = image;
        
        //保存
        [FDStudent shareFDStudent].myVcard.sound = UIImageJPEGRepresentation(image, 1.0);
        [[FDStudent shareFDStudent] updateMyvCard];
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
