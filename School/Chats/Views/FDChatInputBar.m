//
//  FDChatInputBar.m
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatInputBar.h"
#import "FDChatMessageEmoji.h"
#import "FDChatVoiseView.h"
#import "UIResponder+FDExtension.h"
#import "FDChatModel.h"
#import "FDEmojiModel.h"
#import "FDTextView.h"



@interface FDChatInputBar() <UITextViewDelegate>{
    
    /**
     *  @brief  TextView的高度
     */
    CGFloat _heightTextView;

    /**
     *  @brief  TextView和自己底部约束，会被动态增加、删除
     */
    NSLayoutConstraint *_textViewBottomConstraint;
    
    
    /**
     *  @brief  自己和父控件 底部约束，使用这个约束让自己伴随键盘移动
     */
    NSLayoutConstraint *_bottomConstraintWithSupView;

    /**
     *  @brief  表情视图
     */
    FDChatMessageEmoji  *_faceView;
    
    /**
     *  @brief  输入TextView
     */
    FDTextView *_inputTextView;
    
    /**
     *  @brief  voise视图
     */
    FDChatVoiseView *_voiseView;
    
    /**
     *  发送按钮
     */
    UIButton *_sendBtn;
    
}

@end

//输入框最大高度和最小高度
#define inputTextViewMaxHeight             80
#define inputTextViewMinHeight             34
//输入框和其他底部之间的距离
#define inputTextViewToBottomMargin         5


@implementation FDChatInputBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupViews];
        
        [self setupContrains];
    }
    
    return self;
}

/**
 *  添加视图
 */
- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
        //_voiceBtn
    _voiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: _voiseBtn];
    _voiseBtn.backgroundColor = [UIColor clearColor];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_voiseBtn addTarget:self action:@selector(voiseBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //_sendBtn
    _sendBtn = [[UIButton alloc] init];
    [self addSubview:_sendBtn];
    _sendBtn.backgroundColor = [UIColor grayColor];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    _sendBtn.alpha = 0.5;
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _sendBtn.layer.cornerRadius = 4;
    _sendBtn.layer.masksToBounds = YES;
    [_sendBtn addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
    
    //_faceBtn
    _faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: _faceBtn];
    _faceBtn.backgroundColor = [UIColor clearColor];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_faceBtn addTarget:self action:@selector(faceBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //_inputTextView
    _inputTextView = [[FDTextView alloc] init];
    [self addSubview:_inputTextView];
    _inputTextView.delegate = self;  //设置代理
    _inputTextView.alpha = 0.8;
    _inputTextView.layer.cornerRadius = 4;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.layer.borderWidth = 1;
    _inputTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    _inputTextView.scrollEnabled = NO;
    _inputTextView.scrollsToTop = NO;
    _inputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 4.0f);
    _inputTextView.contentInset = UIEdgeInsetsZero;
    _inputTextView.userInteractionEnabled = YES;
    //// 1.如果是普通文字（text），文字大小由textView.font控制,这里其实是属性文字（attributedText），文字大小不受textView.font控制，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
    _inputTextView.font = [UIFont systemFontOfSize:16];
    _inputTextView.textColor = [UIColor blackColor];
    _inputTextView.backgroundColor = [UIColor whiteColor];
    _inputTextView.keyboardType = UIKeyboardTypeDefault;
    _inputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.textAlignment = NSTextAlignmentLeft;
    _inputTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //添加键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];  //切记退出的时候一定要取消监听，否则会崩溃
    
}

/**
 *  发送信息
 */
- (void)sendMessageClick
{
    if (_inputTextView.text.length != 0) {
        FDChatModel *model = [[FDChatModel alloc] init];
        model.body = _inputTextView.text;
        NSDictionary *userInfo = @{KModelKey : model};
        [self routerEventWithType:EventChatCellTypeSendMsgEvent userInfo:userInfo];
        
        _inputTextView.text = @"";
        [self textViewDidChange:_inputTextView];  //重新布局
    }
}


/**
 *  添加约束
 */
- (void)setupContrains
{
    CGFloat margin = 5;
    CGFloat size = inputTextViewMinHeight;
     //_voiseBtn，设置大小和位置
    [_voiseBtn autoSetDimensionsToSize:CGSizeMake(size, size)];
    [_voiseBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:margin];
    [_voiseBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    
    //_sendBtn;
    [_sendBtn autoSetDimensionsToSize:CGSizeMake(size + 5, 30)];
    [_sendBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:margin];
    [_sendBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_voiseBtn];
    
    //_faceBtn  设置大小和位置
    [_faceBtn autoSetDimensionsToSize:CGSizeMake(size, size)];
    [_faceBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_sendBtn withOffset:-margin];
    [_faceBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    
    //_inputTextView  设置顶部距离，底部距离，设置位置,默认最小高度
    [_inputTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_voiseBtn];
    [_inputTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_voiseBtn withOffset:margin];
    [_inputTextView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_faceBtn withOffset:-margin];
    _textViewBottomConstraint = [_inputTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:inputTextViewToBottomMargin];  //inputview和父控件的底部约束
    //_inputTextView的高度
    _heightTextView = inputTextViewMinHeight;
    
}

//获取自己和父控件底部约束，控制该约束可以让自己一整个伴随键盘移动
-(void)updateConstraints
{
    [super updateConstraints];
    
    
    if (!_bottomConstraintWithSupView)
    {
        NSArray *constraints = self.superview.constraints;
        
        for (int index= (int)constraints.count-1; index>0; index--)
        {//从末尾开始查找
            NSLayoutConstraint *constraint = constraints[index];
            
            if (constraint.firstItem == self && constraint.firstAttribute == NSLayoutAttributeBottom && constraint.secondAttribute == NSLayoutAttributeBottom)
            {//获取自己和父控件底部约束
                _bottomConstraintWithSupView = constraint;
                
                break;
            }
        }
    }
    
}

/**
 *  添加键盘监听，自己一整个伴随键盘移动
 */
- (void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *notificationInfo = [notification userInfo];
    
    NSTimeInterval duration;
    UIViewAnimationCurve *curve;
    CGRect keyboardFrame;
    
    [[notificationInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&duration];
    [[notificationInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&curve];
    [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    [UIView animateWithDuration:duration animations:^{
       //修改inputbar距离父控件的距离
        if (notification.name == UIKeyboardWillShowNotification) {
            _bottomConstraintWithSupView.constant = -keyboardFrame.size.height;
            //inputbar将会发生改变，发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kInputBarFrameDidChangeNotification object:self];
            [self.superview layoutIfNeeded];

        }
        if (notification.name == UIKeyboardWillHideNotification) {
            _bottomConstraintWithSupView.constant = 0;
        }
    }];
}

/**
 *  设置自己的固有初始尺寸，当view的固有尺寸发生改变的时候，会重新调用这个方法
 *
 *  @return 只刷新高度，不设置宽度
 */
- (CGSize)intrinsicContentSize
{
    //获取高度
    CGFloat height = _heightTextView + inputTextViewToBottomMargin*2;
    
    if (_faceView){
        //加上——_faceBtn的高度，如果在显示的话
        height += [_faceView intrinsicContentSize].height;
    }
    if (_voiseView){
        //加上——voise的高度，如果在显示的话
        height += [_voiseView intrinsicContentSize].height;
    }
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

/**
 *  单击了voisebtn方法，显示和关录音按钮
 */
- (void)voiseBtnDidClick:(UIButton *)sender
{
    //隐藏face
    if (_faceView) {
        [self faceBtnDidClick:_faceBtn];
    }
    
    //切换按钮状态
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //注销第一响应者
        [_inputTextView resignFirstResponder];
        
        //弹出按钮声音按钮弹框
        _voiseView = [[FDChatVoiseView alloc] init];
        [self addSubview:_voiseView];
        
        //_voiseView 添加约束,已经有固定高度，只需要设置底部，左右约束即可
        [_voiseView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_voiseView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_voiseView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_inputTextView withOffset:5];
        
        //从新设置textview与自己底部的约束
        _textViewBottomConstraint.constant = -(inputTextViewToBottomMargin + [_voiseView intrinsicContentSize].height);
    }else{
        //从父类移除
        [_voiseView removeFromSuperview];
        _voiseView = nil;
        //重新设置inputextview和自己底部的约束
        _textViewBottomConstraint.constant = -inputTextViewToBottomMargin;
    }
    //inputbar 将会改变，发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kInputBarFrameDidChangeNotification object:self];
    //在下次布局规划的时候重新计算自己的高度
    [self invalidateIntrinsicContentSize];
}
/**
 *  单击表情，显示和关闭表情菜单
 */
- (void)faceBtnDidClick:(UIButton *)sender
{
    //隐藏voise弹出的部分
    if (_voiseView) {
        [self voiseBtnDidClick:_voiseBtn];
    }
    
    //切换状态
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //注销第一响应者
        [_inputTextView resignFirstResponder];
        
        //弹出按钮声音按钮弹框
        _faceView = [[FDChatMessageEmoji alloc] init];
        [self addSubview:_faceView];
        //添加block处理
        __weak typeof(_inputTextView) weakInputTextView = _inputTextView;
        _faceView.emojiBlock = ^(FDEmojiModel *model, doType type){
            //表情处理，删除或者插入
            if (type == deleteEmoji) {
                [weakInputTextView insertEmojiName:model.emojiName doType:YES];
            }else{
                [weakInputTextView insertEmojiName:model.emojiName doType:NO];
            }
        };
        
        
        //_faceView 添加约束,已经有固定高度，只需要设置底部，左右约束即可
        [_faceView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_faceView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_faceView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_inputTextView withOffset:5];
        
        //从新设置textview与自己底部的约束
        _textViewBottomConstraint.constant = -(inputTextViewToBottomMargin + [_faceView intrinsicContentSize].height);
    }else{
        //从父类移除
        [_faceView removeFromSuperview];
        _faceView = nil;
        //重新设置inputextview和自己底部的约束
        _textViewBottomConstraint.constant = -inputTextViewToBottomMargin;
    }

    //inputbar 将会改变，发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kInputBarFrameDidChangeNotification object:self];
    
    //在下次布局规划的时候重新计算自己的高度
    [self invalidateIntrinsicContentSize];
    
}

#pragma mark - UITextView delegate
//开始编辑，隐藏其他的视图
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //隐藏_faceview弹出的部分
    if (_faceView) {
        [self faceBtnDidClick:_faceBtn];
    }
    
    if (_voiseView) {
        [self voiseBtnDidClick:_voiseBtn];
    }
}

//根据输入文字的数量，自动调整textview大小
- (void)textViewDidChange:(UITextView *)textView
{
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];   //必须使用这种写法，不可以采用size = textView.contentSize.
    CGFloat height;
    
    if (size.height > inputTextViewMaxHeight) {
        height = inputTextViewMaxHeight;
        if (textView.scrollEnabled == NO){
            textView.scrollEnabled = YES;
        }
    }else{
        if (textView.scrollEnabled == YES) {
            textView.scrollEnabled = NO;
        }
        height = size.height;
    }
    if (_heightTextView != height) {
        _heightTextView = height;
        [self invalidateIntrinsicContentSize];   //重新布局
    }
}

@end
