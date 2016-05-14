//
//  FDContactViewCell.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDContactViewCell.h"
#import "FDContactModel.h"
#import "XMPPvCardTemp.h"



@interface FDContactViewCell(){
    
    UIImageView *_iconView;      //头像
    UILabel *_nickName;     //昵称,社团的部门名称
    UILabel *_accocunt;     //账号
    UILabel *_messageLab;   //新信息条数
    
}

@property (nonatomic, assign, getter=isRemark) BOOL remark;

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
    _accocunt.text = [contactModel.jidStr substringWithRange:NSMakeRange(0, contactModel.jidStr.length - ServerName.length - 1)];
    
    if (contactModel.nickname.length && ![contactModel.nickname isEqualToString:_accocunt.text]) {  //自己已经设置了备注,而且使用备注和用户账户不同
        _nickName.text = contactModel.nickname;
        self.remark = YES;
    }else{//没有备注
        self.remark = NO;
    }
    
    switch ([contactModel.sectionNum intValue]) {//好友状态
        case 0:
            _nickName.textColor = [UIColor redColor];
            _accocunt.textColor = [UIColor redColor];
            break;
        case 1:
            _nickName.textColor = [UIColor grayColor];
            _accocunt.textColor = [UIColor grayColor];
            break;
        case 2:
            _nickName.textColor = [UIColor blackColor];
            _accocunt.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }

}

- (void)setVCard:(XMPPvCardTemp *)vCard
{
    _vCard = vCard;
    
    _iconView.image = [[UIImage imageWithData:self.vCard.photo] imageWithSize:CGSizeMake(40, 40)];
    [_iconView addCorner:10];
    
    if (!self.isRemark) {
        //没有使用备注, 使用用户的vcard上nickname
        if (self.vCard.nickname.length) {
            _nickName.text = self.vCard.nickname;
        }else{//用户自己也没有设置昵称，使用用户的account
            _nickName.text = _accocunt.text;
        }
    }
    

}
/**
 *  添加控件
 */
- (void)setupViews
{
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    _iconView.backgroundColor = [UIColor clearColor];
    
    _nickName = [[UILabel alloc] init];
    [self.contentView addSubview:_nickName];
    _nickName.font = [UIFont boldSystemFontOfSize:14];
    _nickName.textColor = [UIColor blackColor];
    
    _accocunt = [[UILabel alloc] init];
    [self.contentView addSubview:_accocunt];
    _accocunt.font = [UIFont systemFontOfSize:13];
    _accocunt.textColor = [UIColor grayColor];
    
    _messageLab = [[UILabel alloc] init];
    [self.contentView addSubview:_messageLab];
    _messageLab.layer.cornerRadius = 10;
    _messageLab.layer.masksToBounds = YES;
    _messageLab.backgroundColor = [UIColor redColor];
    _messageLab.hidden = YES;
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMessageLab:) name:kNotificationReciveNewMsg object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMessageLab:) name:kNotificationNewMsgDidRead object:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  显示有信息来时的小圆点
 */
- (void)changeMessageLab:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSString *jidStr = [userInfo objectForKey:@"jidStr"];
    if ([jidStr isEqualToString:self.contactModel.jidStr]) {

        if ([notification.name isEqualToString:kNotificationReciveNewMsg]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _messageLab.hidden = NO;
            });
        }
        if ([notification.name isEqualToString:kNotificationNewMsgDidRead]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _messageLab.hidden = YES;
            });
        }
        

    }
    
    
}
#define IconToSuperMargin   5   //icon距离父控件左、上、下的距离
#define IconSizeWidth       40
#define nikeNameMarginTop      5
#define nikeNameMarginLeft       15
/**
 *  设置控件约束
 */
- (void)setupContraint
{
    //_iconView
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:IconToSuperMargin];
    [_iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:IconToSuperMargin];
    [_iconView autoSetDimensionsToSize:CGSizeMake(IconSizeWidth, IconSizeWidth)];
    
    //_nickName
    [_nickName sizeToFit];
    [_nickName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:nikeNameMarginTop];
    [_nickName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:nikeNameMarginLeft];
    
     //_account
    [_accocunt sizeToFit];
    [_accocunt autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nickName];
    [_accocunt autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:nikeNameMarginTop];
    
    //_messageLab
    [_messageLab autoSetDimensionsToSize:CGSizeMake(17, 17)];
    [_messageLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nickName];
    [_messageLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
}




@end
