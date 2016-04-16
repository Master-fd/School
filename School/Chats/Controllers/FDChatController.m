//
//  FDChatController.m
//  School
//  聊天界面控制器
//  Created by asus on 16/3/17.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDChatController.h"
#import "FDChatInputBar.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDChatModel.h"
#import "FDBaseChatViewCell.h"
#import "FDChatTextViewCell.h"
#import "UIResponder+FDExtension.h"

#define kMaxBachSize      (30)    //每次最多从数据库读取30条数据
#define kPageSize         (10)    //一页10条数据

@interface FDChatController ()<UITableViewDataSource, UITableViewDelegate>{
    
    UIRefreshControl *_refreshView;
    
}
@property (nonatomic, strong) FDChatInputBar *inputBar;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FDChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置view
    [self setupViews];
    
    //设置约束
    [self setupContrains];
 
    //滚动到底部
    [self scrollToBottom:YES];
    
    
}


/**
 *  单击view界面，退出键盘或者faceview，或者voiseview
 */
- (void)chatViewDidTap:(UITapGestureRecognizer *)tap
{
    if (self.inputBar) {
        [self.view endEditing:YES];  //退出键盘
        if (self.inputBar.voiseBtn.selected) {
            [self.inputBar voiseBtnDidClick:self.inputBar.voiseBtn];
        }
        
        if (self.inputBar.faceBtn.selected) {
            [self.inputBar faceBtnDidClick:self.inputBar.faceBtn];
        }
    }
}

/**
 *  添加views inputbar
 */
- (void)setupViews
{
    //添加手势识别器，方便退出键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chatViewDidTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //初始化tableview, 注册cell
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //没有横线
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[FDChatTextViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(0, FDChatCellType_Text)];   //接收到的文本信息
    [_tableView registerClass:[FDChatTextViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(1, FDChatCellType_Text)];    //自己发送的文本信息
    
    //初始化刷新控件
    _refreshView = [[UIRefreshControl alloc] init];
    [_refreshView addTarget:self action:@selector(refreshLoadMoreMessage) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshView];
    
    
    //初始化 inputbar
    _inputBar = [[FDChatInputBar alloc] init];
    [self.view addSubview:_inputBar];
    
    //监听inputbar发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrameTableview) name:kInputBarFrameDidChangeNotification object:_inputBar];
    
}

/**
 *  移动tableview
 */
- (void)changeFrameTableview
{
    [self scrollToBottom:YES];
}
/**
 *  添加约束
 */
- (void)setupContrains
{
    //添加约束
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    //tableview约束
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:insets excludingEdge:ALEdgeBottom];
    
    //inputbar约束
    [_inputBar autoPinEdgesToSuperviewEdgesWithInsets:insets excludingEdge:ALEdgeTop];
    [_inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tableView];
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_username"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

/**
 *  查看好友属性按钮被点击，进入查看
 */
- (void)rightBarButtonClick
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  返回好友列表按钮被点击
 */
- (void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - messageSources懒加载
- (NSMutableArray *)messageSources
{
    if (!_messageSources) {
        _messageSources = [NSMutableArray array];
        
        for (int i=0; i<3; i++) {
            FDChatModel *model = [[FDChatModel alloc] init];
            model.meSender = i%2;
            
            model.chatCellType = FDChatCellType_Text;
            model.text = @"ji[004]sada[002]hui";
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

    return self.messageSources.count;
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
    return [tableView fd_heightForCellWithIdentifier:kCellReuseID(chatModel) cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureDataForCell:cell AtIndexPath:indexPath];
    }];
}

//cell 设置数据
- (void)configureDataForCell:(FDBaseChatViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    //取得数据
    FDChatModel *chatModel = self.messageSources[indexPath.row];
    
    //设置数据
    cell.chatmodel = chatModel;
}


#pragma mark - 公共方法

/**
 *  处理路由信息,对路由信息类型进行处理
 */
- (void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo
{
    //解析数据
    FDChatModel *model = [userInfo objectForKey:KModelKey];
    
    switch (eventType) {
        case EventChatCellTypeSendMsgEvent:
            FDLog(@"发送信息:%@", model.text);
            break;
            
        case EventChatCellHeadTapedEvent:
            FDLog(@"头像被点击");
            break;
            
        case EventChatCellHeadLongPressEvent:
            FDLog(@"头像被长按");
            break;
            
        case EventChatCellImageTapedEvent:
            FDLog(@"图片被点击");
            break;
            
        case EventChatCellRemoveEvent:
            FDLog(@"删除事件");
            break;
            
        case EventChatMoreViewPickerImage:
            FDLog(@"更多界面");
            break;
            
        default:
            break;
    }
}

/**
 *  滚动到底部
 */
-(void)scrollToBottom:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger count = self.messageSources.count;
        if (count >=1) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
    });
}

-(void)loadMoreMessage
{
    
}

/**
 *  下拉刷新，添加更多
 */
- (void)refreshLoadMoreMessage
{
    NSLog(@"从数据库中加载数据，每次最多加载30条数据");
    //联网刷新数据
    [self loadMoreMessage];
    //启动计时器
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(refreshTimerOut) userInfo:nil repeats:NO];
}

/**
 *  刷新超时
 */
- (void)refreshTimerOut
{
    [_refreshView endRefreshing];
    
    FDLog(@"已经没有更多的数据");
}


@end
