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
    UITextView *_inputTextView;
    
    /**
     *  @brief  录制语音按钮
     */
    UIButton   *_voiseBtn;
    
    /**
     *  @brief  表情按钮
     */
    UIButton   *_faceBtn;
    
    /**
     *  @brief  表情voise视图
     */
    FDChatVoiseView *_voiseView;
}
@end

//输入框最大高度和最小高度
#define inputTextViewMaxHeight             34
#define inputTextViewMinHeight             84
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
    //_voiceBtn
    _voiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: _voiseBtn];
    _voiseBtn.backgroundColor = [UIColor clearColor];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateHighlighted];
    [_voiseBtn setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_voiseBtn addTarget:self action:@selector(voiseBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //_faceBtn
    _faceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: _faceBtn];
    _faceBtn.backgroundColor = [UIColor clearColor];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_press"] forState:UIControlStateHighlighted];
    [_faceBtn setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateSelected];
    [_faceBtn addTarget:self action:@selector(faceBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //_inputTextView
    _inputTextView = [[UITextView alloc] init];
    [self addSubview:_inputTextView];
    _inputTextView.delegate = self;  //设置代理
    _inputTextView.layer.cornerRadius = 4;
    _inputTextView.layer.masksToBounds = YES;
    _inputTextView.layer.borderWidth = 1;
    _inputTextView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    _inputTextView.scrollEnabled = NO;
    _inputTextView.scrollsToTop = NO;
    _inputTextView.scrollIndicatorInsets = UIEdgeInsetsMake(10, 0, 10, 4);
    _inputTextView.contentInset = UIEdgeInsetsZero;
    _inputTextView.userInteractionEnabled = YES;
    _inputTextView.font = [UIFont systemFontOfSize:14];
    _inputTextView.textColor = [UIColor blackColor];
    _inputTextView.backgroundColor = [UIColor whiteColor];
    _inputTextView.keyboardType = UIKeyboardTypeDefault;
    _inputTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.textAlignment = NSTextAlignmentLeft;
    
    
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
    
    //_faceBtn  设置大小和位置
    [_faceBtn autoSetDimensionsToSize:CGSizeMake(size, size)];
    [_faceBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:margin];
    [_faceBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:margin];
    
    //_inputTextView  设置顶部距离，底部距离，设置位置
    [_inputTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_voiseBtn];
    [_inputTextView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_voiseBtn withOffset:margin];
    [_inputTextView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_faceBtn withOffset:margin];
    _textViewBottomConstraint = [_inputTextView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:inputTextViewToBottomMargin];
    //_inputTextView的最小高度
    _heightTextView = inputTextViewMinHeight;
    
}

/**
 *  设置自己的固有初始尺寸，当view的固有尺寸发生改变的时候，会重新调用这个方法
 *
 *  @return 值刷新高度，不设置宽度
 */
- (CGSize)intrinsicContentSize
{
    //获取高度
    CGFloat height = _heightTextView + inputTextViewToBottomMargin;
    
    if (_faceView) {
        //加上face的高度，如果face在显示的话
        height += [_faceView intrinsicContentSize].height;
    }else if (_voiseView){
        //加上——voise的高度，如果在显示的话
        height += [_voiseView intrinsicContentSize].height;
    }
    
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}


- (void)voiseBtnDidClick:(UIButton *)sender
{
    //隐藏face
    if (_faceBtn.selected) {
        [self faceBtnDidClick:_faceBtn];
    }
    
    //切换按钮状态
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
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
    
    //在下次布局规划的时候重新计算自己的高度
    [self invalidateIntrinsicContentSize];
    
    FDLog(@"voiseBtn被点击了");
}

- (void)faceBtnDidClick:(UIButton *)sender
{
    
    //隐藏voise弹出的部分
    if (_voiseBtn.selected) {
        [self voiseBtnDidClick:_voiseBtn];
    }
    
    //切换状态
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //添加faceview
        _faceView = [[FDChatMessageEmoji alloc] init];
        [self addSubview:_faceView];
        
        //设置faceview 的约束,高度已经固定了，只需要设置左右下
        [_faceView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_faceView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_faceView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_inputTextView withOffset:5];
        
        //重新设置textview与自己的底部约束
        _textViewBottomConstraint.constant = -(inputTextViewToBottomMargin + [_faceView intrinsicContentSize].height);
    }else{
        //从父类移除
        [_faceView removeFromSuperview];
        _faceView = nil;
        
        //重新设置textview的与底部约束
        _textViewBottomConstraint.constant = -inputTextViewToBottomMargin;
    }
    
    //在下次布局规划的时候重新计算自己的高度
    [self invalidateIntrinsicContentSize];
    
   
    FDLog(@"表情按钮被点击");
}
@end
