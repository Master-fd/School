//
//  FDEditlPhotoController.m
//  School
//
//  Created by asus on 16/4/20.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditlPhotoController.h"
#import "FDStudent.h"
#import "XMPPvCardTemp.h"
#import "UIImage+FDExtension.h"


@interface FDEditlPhotoController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImageView *_iconView;
    
    UIButton *_albumBtn;
    
}

@end

@implementation FDEditlPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
}

- (void)setupViews
{
    
    _iconView = [[UIImageView alloc] init];
    [self.view addSubview:_iconView];
    if ([FDStudent shareFDStudent].photo.length) {
        _iconView.image = [UIImage imageWithData:[FDStudent shareFDStudent].photo];
    }else{
        _iconView.image = [UIImage imageNamed:@"user_avatar_default"];
    }
    
    _albumBtn = [[UIButton alloc] init];
    [self.view addSubview:_albumBtn];
    
    [_albumBtn addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchDown];
    _albumBtn.backgroundColor = [UIColor whiteColor];
    [_albumBtn setTitle:@"从相册获取" forState:UIControlStateNormal];
    [_albumBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _albumBtn.titleLabel.alpha = 0.9;
    _albumBtn.layer.cornerRadius = 6;
    _albumBtn.layer.masksToBounds = YES;
}

- (void)setupContraints
{
    [_iconView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_iconView autoSetDimensionsToSize:CGSizeMake(80, 80)];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:80];
    
    [_albumBtn autoSetDimension:ALDimensionHeight toSize:40];
    [_albumBtn autoSetDimension:ALDimensionWidth toSize:250];
    [_albumBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_iconView withOffset:20];
    [_albumBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
}

/**
 *  打开相册,或则相机
 */
- (void)openAlbum
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)savePhoto:(UIImage *)image
{
    if (image) {
        NSData *data = UIImagePNGRepresentation(image);
        [FDStudent shareFDStudent].myVcard.photo = data;
        [[FDStudent shareFDStudent] updateMyvCard];
    }
}

#pragma mark - UIImagePickerController delegate
//选择了图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    image = [image imageWithSize:CGSizeMake(70, 70)];
    _iconView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self savePhoto:image];
}




@end




