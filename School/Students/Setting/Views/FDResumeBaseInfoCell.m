//
//  FDResumeBaseInfoCell.m
//  School
//
//  Created by asus on 16/4/21.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDResumeBaseInfoCell.h"


#define kCellHeight     150
#define kmarge          15  //行与行之间的间隔
#define kfontSize       14
@interface FDResumeBaseInfoCell(){
    UIView *_bgView;
    UIButton *_editBtn;
    UILabel *_nameLab;
    UILabel *_majorLab;
    UILabel *_phoneNumberLab;
    UILabel *_emailLab;
}


@end

@implementation FDResumeBaseInfoCell



+ (FDResumeBaseInfoCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * const CellId = @"infoCell";
    FDResumeBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[FDResumeBaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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
    
    _editBtn = [[UIButton alloc] init];
    [_bgView addSubview:_editBtn];
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"icon_edit_text"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchDown];
    
    _nameLab = [[UILabel alloc] init];
    [_bgView addSubview:_nameLab];
    _nameLab.font = [UIFont systemFontOfSize:kfontSize];
    _nameLab.textColor = [UIColor grayColor];
    _nameLab.text = @"姓      名：";
    
    _majorLab = [[UILabel alloc] init];
    [_bgView addSubview:_majorLab];
    _majorLab.font = [UIFont systemFontOfSize:kfontSize];
    _majorLab.textColor = [UIColor grayColor];
    _majorLab.text = @"专      业：";
    
    _phoneNumberLab = [[UILabel alloc] init];
    [_bgView addSubview:_phoneNumberLab];
    _phoneNumberLab.font = [UIFont systemFontOfSize:kfontSize];
    _phoneNumberLab.textColor = [UIColor grayColor];
    _phoneNumberLab.text = @"联系电话：";
    
    _emailLab = [[UILabel alloc] init];
    [_bgView addSubview:_emailLab];
    _emailLab.font = [UIFont systemFontOfSize:kfontSize];
    _emailLab.textColor = [UIColor grayColor];
    _emailLab.text = @"邮箱地址：";
    
/*****************************************/
    _name = [[UILabel alloc] init];
    [_bgView addSubview:_name];
    _name.font = [UIFont systemFontOfSize:kfontSize];
    _name.textColor = [UIColor grayColor];
    
    _major = [[UILabel alloc] init];
    [_bgView addSubview:_major];
    _major.font = [UIFont systemFontOfSize:kfontSize];
    _major.textColor = [UIColor grayColor];
    
    _phoneNumber = [[UILabel alloc] init];
    [_bgView addSubview:_phoneNumber];
    _phoneNumber.font = [UIFont systemFontOfSize:kfontSize];
    _phoneNumber.textColor = [UIColor grayColor];
    
    _email = [[UILabel alloc] init];
    [_bgView addSubview:_email];
    _email.font = [UIFont systemFontOfSize:kfontSize];
    _email.textColor = [UIColor grayColor];
    
}



- (void)setupContraints
{
    
    [_bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    [_nameLab sizeToFit];
    [_nameLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kmarge];
    [_nameLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kmarge];
    [_nameLab autoSetDimension:ALDimensionWidth toSize:70];
    
    [_majorLab sizeToFit];
    [_majorLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameLab];
    [_majorLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLab withOffset:kmarge];
    [_majorLab autoSetDimension:ALDimensionWidth toSize:70];
    
    [_phoneNumberLab sizeToFit];
    [_phoneNumberLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_majorLab];
    [_phoneNumberLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_majorLab withOffset:kmarge];
    [_phoneNumberLab autoSetDimension:ALDimensionWidth toSize:70];
    
    [_emailLab sizeToFit];
    [_emailLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_phoneNumberLab];
    [_emailLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneNumberLab withOffset:kmarge];
    [_emailLab autoSetDimension:ALDimensionWidth toSize:70];
    
    [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    [_editBtn autoSetDimensionsToSize:CGSizeMake(45, 13)];
    [_editBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_nameLab];
    
    /****************************************************************/
    

    [_name autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nameLab withOffset:5];
    [_name autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nameLab];
    [_name autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_nameLab];
    [_name autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_editBtn withOffset:-5];

    [_major autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_majorLab withOffset:5];
    [_major autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_majorLab];
    [_major autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_majorLab];
    [_major autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    
    [_phoneNumber autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_phoneNumberLab withOffset:5];
    [_phoneNumber autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_phoneNumberLab];
    [_phoneNumber autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_phoneNumberLab];
    [_phoneNumber autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];
    
    [_email autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_emailLab withOffset:5];
    [_email autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_emailLab];
    [_email autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_emailLab];
    [_email autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kmarge];

}

#pragma mark -  公共方法
//修改按钮被点击
- (void)editBtnClick
{
    if (self.infoBlock) {
        self.infoBlock();
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
