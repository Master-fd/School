//
//  FDContactViewCell.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDContactViewCell.h"
#import "FDContactModel.h"




@interface FDContactViewCell(){
    
    UIImageView *_iconView;      //头像
    UILabel *_userName;      //名称,社团名称
    UILabel *_nikeName;     //昵称,社团的部门名称
    UILabel *_accocunt;     //账号
}



@end

@implementation FDContactViewCell

+ (instancetype)contactViewCellWithTableView:(UITableView *)tableview
{
    FDContactViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[FDContactViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加控件
        [self setupViews];
        //添加约束
        [self setupContraint];
    
    }
    
    return self;
}
/**
 *  懒加载，设置数据
 */
- (void)setContactModel:(FDContactModel *)contactModel
{
    _contactModel = contactModel;
    
    //设置数据
    _iconView.image = [UIImage imageWithData:contactModel.icon];
    _userName.text = contactModel.userName;
    
    if (contactModel.nikeName) {
        _nikeName.hidden = NO;
        _nikeName.text = [NSString stringWithFormat:@"(%@)", contactModel.nikeName];
    }else{
        _nikeName.hidden = YES;
    }
    _accocunt.text = contactModel.account;

}

/**
 *  添加控件
 */
- (void)setupViews
{
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    
    _userName = [[UILabel alloc] init];
    [self.contentView addSubview:_userName];
    _userName.font = [UIFont systemFontOfSize:16];
    
    _nikeName = [[UILabel alloc] init];
    [self.contentView addSubview:_nikeName];
    _nikeName.font = [UIFont systemFontOfSize:14];
    _nikeName.hidden = YES;
    
    _accocunt = [[UILabel alloc] init];
    [self.contentView addSubview:_accocunt];
    _accocunt.font = [UIFont systemFontOfSize:14];
    
}

#define IconToSuperMargin   5   //icon距离父控件左、上、下的距离
#define IconSizeWidth       40
#define userNameMargin      5   //username 距离其他控件的距离
#define nikeNameMargin      5
#define accountMargin       5
/**
 *  设置控件约束
 */
- (void)setupContraint
{
    //_iconView
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:IconToSuperMargin];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:IconToSuperMargin];
    [_iconView autoSetDimensionsToSize:CGSizeMake(IconSizeWidth, IconSizeWidth)];
    
    //_userName
    [_userName sizeToFit];
    [_userName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:userNameMargin];
    [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:userNameMargin];
    
    //_nikeName
    [_nikeName sizeToFit];
    [_nikeName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_userName];
    [_nikeName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_userName withOffset:nikeNameMargin];
    
    //_account
    [_accocunt sizeToFit];
    [_accocunt autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_userName];
    [_accocunt autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_userName withOffset:accountMargin];
    
}




@end
