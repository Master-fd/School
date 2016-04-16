//
//  FDChatTextViewCell.m
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatTextViewCell.h"
#import "FDLable.h"


@interface FDChatTextViewCell(){
    //聊天内容为文本信息
    FDLable *_textLab;
}

@end



@implementation FDChatTextViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setupViews];
        
        [self setupContraint];
    }
    
    return self;
}

/**
 *  新建views
 */
- (void)setupViews
{
    _textLab = [[FDLable alloc] initForAutoLayout];
    [self.contentView addSubview:_textLab];
    _textLab.backgroundColor = [UIColor clearColor];
    _textLab.font = [UIFont systemFontOfSize:16];
    _textLab.textColor = [UIColor blackColor];
    _textLab.alpha = 0.8;
    _textLab.numberOfLines = 0;//自动换行
    
}


/**
 *  设置views 的约束
 */
- (void)setupContraint
{
    //根据内容,设置contentBg的宽高  w h
    [self.contentBg autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_textLab withOffset:BgToContentBottomMargin];
    if (self.isSender) {//w
        //自己发送的文本信息
        [self.contentBg autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_textLab withOffset:-BgToContentLorRMargin];
    }else{
        //接收到的文本信息
        [self.contentBg autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_textLab withOffset:BgToContentLorRMargin];
    }

    //设置_textLab的X Y 和宽高

    [_textLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.headIconBtn withOffset:ContentToHeadIconTop];//y
    [_textLab autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:ContentToSuperBottom];//h
    if (self.isSender) {  //自己发送的信息   x  w
        [_textLab autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.headIconBtn withOffset:-ContentToHeadIconLorR];//x
        [_textLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:ContentToSuperLorR relation:NSLayoutRelationGreaterThanOrEqual]; //w
    } else {//接收到的信息
        [_textLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.headIconBtn withOffset:ContentToHeadIconLorR];
        [_textLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:ContentToSuperLorR relation:NSLayoutRelationGreaterThanOrEqual]; //w
    }

    
}


//懒加载，设置数据
- (void)setChatmodel:(FDChatModel *)chatmodel
{
    [_textLab AttributedTextFromText:chatmodel.text];
    [super setChatmodel:chatmodel];
}
/**
 *  重写父类的longpress方法
 *  实现自己需要做的事
 */
- (void)bgDidLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        //成为第一响应者
        [self becomeFirstResponder];
        //设置高亮
        self.contentBg.highlighted = YES;
        //添加菜单
        UIMenuItem *itemCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopy:)];
        UIMenuItem *itemDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuDelete:)];
        UIMenuItem *itemRetweet = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(menuRetweet:)];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:@[itemCopy, itemDelete, itemRetweet]];
        [menu setTargetRect:self.contentBg.frame inView:self];
        [menu setMenuVisible:YES animated:YES];
        
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIMenuControllerWillHideMenu) name:UIMenuControllerDidHideMenuNotification object:nil];
    }
}


/**
 *  菜单已经隐藏
 */
- (void)UIMenuControllerWillHideMenu
{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //取消高亮显示
    self.contentBg.highlighted = NO;
}

/**
 *  可响应事件
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL result = NO;
    if (_textLab.text.length) {
        result = ((action == @selector(menuCopy:)) || (action == @selector(menuDelete:))
                  || (action == @selector(menuRetweet:)));
    }else{
        result = [super canPerformAction:action withSender:sender];
    }
    
    return result;
}
/**
 *  复制
 */
- (void)menuCopy:(id)sender
{
    [UIPasteboard generalPasteboard].string = _textLab.text;
    
    FDLog(@"文本已被复制");
}

/**
 *  删除
 */
- (void)menuDelete:(id)sender
{
    FDLog(@"删除文本信息");
    [self routerEventWithType:EventChatCellRemoveEvent userInfo:@{KModelKey : self.chatmodel}];
}

/**
 *  转发
 */
- (void)menuRetweet:(id)sender
{
    FDLog(@"转发文本信息");
}

@end
