//
//  FDChatMessageEmoji.m
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatMessageEmoji.h"
#import "FDEmojiModel.h"
#import "FDEmojiCollectionViewCell.h"

@interface FDChatMessageEmoji()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    
    UICollectionView *_collectionView;
    
    UIPageControl *_pageControl;
    
}

@property (nonatomic, strong) NSArray *emojiSources;

@end



@implementation FDChatMessageEmoji


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupViews];
        
        [self setupContraints];
    }
    
    return self;
}
/**
 *  初始化添加views
 */
- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    //初始化一个瀑布流
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/7.0-10, (kHeightFaceView - kHeightBtn)/3.0-10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.pagingEnabled =  YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.userInteractionEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[FDEmojiCollectionViewCell class] forCellWithReuseIdentifier:kReuseCellId];
    [self addSubview: _collectionView];
    
    
    //初始化一个pageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = kEmojiCount/(3*7) +1;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = kUnSelectedColorPageControl;
    _pageControl.currentPageIndicatorTintColor = kSelectedColorPageControl;
    [self addSubview:_pageControl];
}

/**
 *  添加约束
 */
- (void)setupContraints
{
    //_collectionView
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 10, 0);
    [_collectionView autoPinEdgesToSuperviewEdgesWithInsets:insets excludingEdge:ALEdgeBottom];
    [_collectionView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_pageControl withOffset:-3];
    //_pageControl
    [_pageControl autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_pageControl autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_pageControl autoSetDimension:ALDimensionHeight toSize:10];
}


/**
 *  懒加载所有表情
 */
- (NSArray *)emojiSources
{
    if (!_emojiSources) {
        _emojiSources = [NSArray array];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        int del = 0;
        for (int i=1; i<=kEmojiCount; i++) {
            FDEmojiModel *model = [[FDEmojiModel alloc] init];
            
            if (!((i+del)%(3*7))) {
                //插入delete
                del++;
                FDEmojiModel *modelDelete = [[FDEmojiModel alloc] init];
                modelDelete.emojiName = [NSString stringWithFormat:@"%d", 0];
                [arrayM addObject:modelDelete];
            }
            
            model.emojiName = [NSString stringWithFormat:@"%03d", i];
            [arrayM addObject:model];  //保持emoji的名称，不要直接是数据，如果是数据，全部加载到内存，会比较消耗内存
        }
        _emojiSources = arrayM;
    }
    
    return _emojiSources;
}


/**
 *  设置自己的初始固有尺寸。只设置高度为170 宽度不设置
 */
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, kHeightFaceView);
}

#pragma mark - UICollectionView   delegate
//section 个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//cell 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.emojiSources.count;
}

//cell 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    
    FDEmojiModel *model = self.emojiSources[indexPath.row];
    
    FDEmojiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCellId forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}

//cell被选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FDEmojiModel *model = self.emojiSources[indexPath.row];
    if ([model.emojiName isEqualToString:@"0"]) {
        if (self.emojiBlock) {
            self.emojiBlock(model, deleteEmoji);
        }
    }else{
        if (self.emojiBlock) {
            self.emojiBlock(model, addEmoji);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = (scrollView.contentOffset.x)/scrollView.bounds.size.width;
}


@end
