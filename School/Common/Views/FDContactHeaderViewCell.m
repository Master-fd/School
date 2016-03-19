//
//  FDContactHeaderViewCell.m
//  School
//
//  Created by asus on 16/3/14.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDContactHeaderViewCell.h"
#import "FDGroupModel.h"

@interface FDContactHeaderViewCell(){
    UIButton *_groupBtn;        //组三角形,组名
    UILabel *_onlineLab;     //在线人数
}

@end

@implementation FDContactHeaderViewCell


+ (instancetype)contactHeaderViewCellWithTableView:(UITableView *)tableview
{
    static NSString * const header_ID = @"header_ID";
    FDContactHeaderViewCell *cell = [tableview dequeueReusableHeaderFooterViewWithIdentifier:header_ID];
    if (cell == nil) {
        cell = [[FDContactHeaderViewCell alloc] initWithReuseIdentifier:header_ID];
    }
    
    return cell;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self setupViews];
        [self setupContraint];
    }
    
    return self;
}

/**
 *  懒加载
 */
- (void)setGroupModel:(FDGroupModel *)groupModel
{
    _groupModel = groupModel;
    
    //设置数据
    [_groupBtn setTitle:groupModel.groupName forState:UIControlStateNormal];
    _onlineLab.text = [NSString stringWithFormat:@"%d/%d", groupModel.onlineCount, groupModel.contactCount];
    //旋转图片
    
    if (groupModel.isVisible) {
        _groupBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _groupBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
/**
 *  初始化views
 */
- (void)setupViews
{
    
    //添加按钮
    _groupBtn = [[UIButton alloc] init];
    [self.contentView addSubview:_groupBtn];
    [_groupBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [_groupBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
    [_groupBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
    [_groupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _groupBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _groupBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _groupBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //设置按钮图片显示模式
    _groupBtn.imageView.contentMode = UIViewContentModeCenter;
    //设置按钮图片超出图片框的时候不要截取
    _groupBtn.imageView.clipsToBounds = NO;
    //为按钮增加单击事件
    [_groupBtn addTarget:self action:@selector(groupBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加lable
    _onlineLab = [[UILabel alloc] init];
    [self.contentView addSubview:_onlineLab];
}

/**
 *  添加约束
 */
- (void)setupContraint
{
    //_groupBtn
    [_groupBtn autoPinEdgesToSuperviewEdges];
    [_groupBtn.titleLabel sizeToFit];
    
    //_onlineLab
    [_onlineLab sizeToFit];
    [_onlineLab autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_onlineLab autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_onlineLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
}

//按键单击事件， 调用代理，通知分组被点击
- (void)groupBtnClick
{
    self.groupModel.visible = !self.groupModel.isVisible;
    
    //旋转图片
    if (_groupModel.isVisible) {
        _groupBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _groupBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    //通知代理，分组已经被点击
    if ([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickButton:)]) {
        [self.delegate groupHeaderViewDidClickButton:self];
    }
}
@end
