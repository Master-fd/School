//
//  FDChatController.m
//  School
//
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatController.h"
#import "FDChatInputBar.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDChatModel.h"
#import "FDBaseChatViewCell.h"
#import "FDChatTextViewCell.h"


@interface FDChatController ()<UITableViewDataSource, UITableViewDataSource>{
    
    FDChatInputBar *_inputBar;
    
    UIRefreshControl *_refreshView;
}
@end

@implementation FDChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置输入框
    [self setupViews];
    
    //设置约束
    [self setupContrains];
    
}

/**
 *  添加views inputbar
 */
- (void)setupViews
{
    //初始化tableview, 注册cell
    [self.tableView registerClass:[FDChatTextViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(0, FDChatCellType_Text)];   //接收到的文本信息
    [self.tableView registerClass:[FDChatTextViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(1, FDChatCellType_Text)];    //自己发送的文本信息
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //没有横线
    
    //初始化刷新控件
    _refreshView = [[UIRefreshControl alloc] init];
    [_refreshView addTarget:self action:@selector(refreshLoadMoreMessage) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshView];
    
    //初始化 inputbar
    _inputBar = [[FDChatInputBar alloc] init];
}
/**
 *  添加约束
 */
- (void)setupContrains
{
    //添加约束
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:insets excludingEdge:ALEdgeBottom];
    
    [_inputBar autoPinEdgesToSuperviewEdgesWithInsets:insets excludingEdge:ALEdgeTop];
    [_inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
}

#pragma mark - messageSources懒加载
- (NSMutableArray *)messageSources
{
    if (!_messageSources) {
        _messageSources = [NSMutableArray array];
        
        for (int i=0; i<100; i++) {
            FDChatModel *model = [[FDChatModel alloc] init];
            model.meSender = YES;
            model.chatCellType = FDChatCellType_Text;
            [_messageSources addObject:model];
        }
    }
    
    return _messageSources;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

//cell显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDChatModel *chatModel = self.messageSources[indexPath.row];
    
    FDBaseChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID(chatModel) forIndexPath:indexPath];
    
    [self configureDataForCell:cell AtIndexPath:indexPath];
    
    return cell;
}

//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDChatModel *chatModel = self.messageSources[indexPath.row];
    
    return [tableView fd_heightForCellWithIdentifier:kCellReuseID(chatModel) configuration:^(FDBaseChatViewCell *cell) {
        [self configureDataForCell:cell AtIndexPath:indexPath];
    }];
}

//cell 设置数据
- (void)configureDataForCell:(FDBaseChatViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    //取得数据
    FDChatModel *chatModel = self.messageSources[indexPath.row];
    
    //设置数据
    
}


#pragma mark - 公共方法
/**
 *  下拉刷新，添加更多
 */
- (void)refreshLoadMoreMessage
{
    NSLog(@"开始联网刷新");
    //联网刷新数据
    
    //启动计时器
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(refreshTimerOut) userInfo:nil repeats:NO];
}

/**
 *  刷新超时
 */
- (void)refreshTimerOut
{
    [_refreshView endRefreshing];
    
    FDLog(@"刷新超时，停止刷新");
}
@end
