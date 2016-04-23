//
//  FDEditBaseInfoCell.m
//  School
//
//  Created by asus on 16/4/23.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDEditBaseInfoView.h"

@interface FDEditBaseInfoView()<UITextFieldDelegate>{
    UIView *_bgView;
    UIImageView *_icon;
    
}

@end

@implementation FDEditBaseInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    
        [self setupViews];
    
        [self setupContraints];
    
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    _bgView = [[UIView alloc] init];
    [self addSubview:_bgView];
    _bgView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_edit_modify"]];
    [self addSubview:_icon];
    
    _textField = [[UITextField alloc] init];
    [self addSubview:_textField];
    _textField.keyboardType = UIKeyboardAppearanceDefault;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    
}


- (void)setupContraints
{
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_bgView autoSetDimension:ALDimensionHeight toSize:1];
    
    [_icon autoSetDimensionsToSize:CGSizeMake(20, 20)];
    [_icon autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_icon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
    [_textField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_icon withOffset:15];
    [_textField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_textField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_icon];
    [_textField autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_icon];
}


#pragma mark - uitextfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   if ([string isEqualToString:@"\n"]) {
        
        [textField resignFirstResponder];

        return NO;
    }
    if (_textField.text.length > 20) {
        
        if (_textField.text.length > 20) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"长度不能超过20个字"];
            });
        }
        return NO;
    }
    return YES;
}


@end
