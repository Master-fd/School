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
    UILabel *_nickName;     //昵称,社团的部门名称
    UILabel *_accocunt;     //账号
    UILabel *_messageLab;   //新信息条数
    
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
    _iconView.image = [UIImage imageWithData:contactModel.photo];
    
    if (contactModel.nickname.length) {
        _nickName.hidden = NO;
        _nickName.text = contactModel.nickname;
    }else{
        _nickName.hidden = YES;
    }
    
    _accocunt.text = [contactModel.jidStr substringWithRange:NSMakeRange(0, contactModel.jidStr.length - ServerName.length - 1)];

}

/**
 *  添加控件
 */
- (void)setupViews
{
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    
    _nickName = [[UILabel alloc] init];
    [self.contentView addSubview:_nickName];
    _nickName.font = [UIFont systemFontOfSize:14];
    _nickName.hidden = YES;
    
    _accocunt = [[UILabel alloc] init];
    [self.contentView addSubview:_accocunt];
    _accocunt.font = [UIFont systemFontOfSize:12];
    
    _messageLab = [[UILabel alloc] init];
    [self.contentView addSubview:_messageLab];
    _messageLab.layer.cornerRadius = 10;
    _messageLab.layer.masksToBounds = YES;
    _messageLab.textColor = [UIColor whiteColor];
    _messageLab.textAlignment = NSTextAlignmentCenter;
    _messageLab.font = [UIFont systemFontOfSize:10];
    _messageLab.backgroundColor = [UIColor redColor];
    _messageLab.hidden = YES;
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMessageLab:) name:kNotificationReciveNewMsg object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMessageLab:) name:kNotificationNewMsgDidRead object:nil];
}

- (void)dealloc
{
    FDLog(@"dealloc");

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeMessageLab:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    //NSString *msg = [userInfo objectForKey:@"body"];
    //NSString *account = [userInfo objectForKey:@"account"];
    NSString *jidStr = [userInfo objectForKey:@"jidStr"];
    
    if ([jidStr isEqualToString:self.contactModel.jidStr]) {
         static int numOfMsg = 0;
        if ([notification.name isEqualToString:kNotificationReciveNewMsg]) {
            numOfMsg += 1;
            if (numOfMsg > 100) {
                numOfMsg = 110;
            }
            _messageLab.hidden = NO;
        }
        
        if ([notification.name isEqualToString:kNotificationNewMsgDidRead]) {
            numOfMsg = 0;
            _messageLab.hidden = YES;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (numOfMsg > 100) {
                _messageLab.text = @"...";
            }else{
                _messageLab.text = [NSString  stringWithFormat:@"%d", numOfMsg];
            }
        });
        
    }
    
    
}
#define IconToSuperMargin   5   //icon距离父控件左、上、下的距离
#define IconSizeWidth       40
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
    
    //_nickName
    [_nickName sizeToFit];
    [_nickName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:nikeNameMargin];
    [_nickName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconView withOffset:nikeNameMargin];
    
     //_account
    [_accocunt sizeToFit];
    [_accocunt autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nickName];
    [_accocunt autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:nikeNameMargin];
    
    //_messageLab
    [_messageLab autoSetDimensionsToSize:CGSizeMake(17, 17)];
    [_messageLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nickName];
    [_messageLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
}




@end
