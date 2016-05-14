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
#import "FDChatController+FDCoreDateExtension.h"
#import "FDAboutFriendController.h"
#import "XMPPvCardTemp.h"
#import "FDUserInfo.h"
#import "FDXMPPTool.h"

#define kMaxBachSize      (30)    //每次最多从数据库读取30条数据
#define kPageSize         (10)    //一页10条数据

@interface FDChatController ()<UITableViewDataSource, UITableViewDelegate>{
    
    UIRefreshControl *_refreshView;
    
}
@property (nonatomic, strong) FDChatInputBar *inputBar;

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //发出通知信息全部被读取
    NSString *msg = @"";
    NSString *jidStr = self.jidStr;
    NSString *account = [jidStr substringWithRange:NSMakeRange(0, jidStr.length-ServerName.length-1)];
    //发出通知
    NSDictionary *userInfo = @{@"body" : msg,
                               @"account" : account,
                               @"jidStr" : jidStr};
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewMsgDidRead object:self userInfo:userInfo];

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
   
    //初始化tableview, 注册cell
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //没有横线
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[FDChatTextViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(0)];   //接收到的文本信息
    [_tableView registerClass:[FDChatTextViewCell class] forCellReuseIdentifier:kCellReuseIDWithSenderAndType(1)];    //自己发送的文本信息
    
    //初始化刷新控件
    _refreshView = [[UIRefreshControl alloc] init];
    [_refreshView addTarget:self action:@selector(refreshLoadMoreMessage) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshView];
    
    
    //初始化 inputbar
    _inputBar = [[FDChatInputBar alloc] init];
    [self.view addSubview:_inputBar];
    
    //监听inputbar发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrameTableview) name:kInputBarFrameDidChangeNotification object:_inputBar];
    
    //添加手势识别器，方便退出键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chatViewDidTap:)];
    [_tableView addGestureRecognizer:tapGesture];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(chatViewDidTap:)];
    [_tableView addGestureRecognizer:swipeGesture];
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beizhuDidchange:) name:kEditBeizhuNotification object:nil];
}
/**
 *  收到通知的时候，马上修改对应的显示
 */
- (void)beizhuDidchange:(NSNotification *)notification
{
    NSString *name = [notification.userInfo objectForKey:kBeizhuNameKey];
    self.title = name;
    self.nickname = name;
}
/**
 *  一定要移除监听
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  查看好友属性按钮被点击，进入查看
 */
- (void)rightBarButtonClick
{
    FDAboutFriendController *vc = [[FDAboutFriendController alloc] init];
    vc.title = self.title;
    vc.jidStr = self.jidStr;   //jid
    vc.nickname = self.nickname;  //备注
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

//cell显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDChatModel *chatModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    FDBaseChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIDWithSenderAndType(chatModel.isOutgoing) forIndexPath:indexPath];
    
    [self configureDataForCell:cell AtIndexPath:indexPath];
    
    return cell;
}

//cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDChatModel *chatModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    return [tableView fd_heightForCellWithIdentifier:kCellReuseIDWithSenderAndType(chatModel.isOutgoing) cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configureDataForCell:cell AtIndexPath:indexPath];
    }];
}

//cell 设置数据
- (void)configureDataForCell:(FDBaseChatViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    //取得数据
    FDChatModel *chatModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //设置数据
    cell.chatmodel = chatModel;
    
    
    if (chatModel.isOutgoing) {
        //自己发送的信息,显示自己的头像
        XMPPvCardTemp *vcard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:[FDUserInfo shareFDUserInfo].jidStr];
        cell.headIconBtn.image = [UIImage imageWithData:vcard.photo];
    }else {
        //好友的信息,显示好友的头像
        XMPPvCardTemp *vcard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:self.jidStr];
        cell.headIconBtn.image = [UIImage imageWithData:vcard.photo];
    }
    

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
            [self sendMessage:model];
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
 *  联网发送信息
 */
- (void)sendMessage:(FDChatModel *)model
{
    //发送chat信息,固定格式
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:self.jidStr]];
    
    //拼接数据
    [msg addBody:model.body];
    
    //发送数据
    [[FDXMPPTool shareFDXMPPTool].xmppStream sendElement:msg];
    //发送完信息，滚动到底部
    [self scrollToBottom:YES];
}
/**
 *  滚动到底部
 */
-(void)scrollToBottom:(BOOL)animated
{    //让其滚动到底部
    dispatch_async(dispatch_get_main_queue(), ^
    {
        NSInteger section = [[self.fetchedResultsController sections] count];
        if (section >= 1)
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section-1];
            NSInteger row =  [sectionInfo numberOfObjects];
            if (row >= 1)
            {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section-1] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
            }
        }
    });
}

/**
 *  加载更多信息
 */
-(void)loadMoreMessage
{
    NSFetchRequest *fetchRequest = self.fetchedResultsController.fetchRequest;
    
    NSUInteger offset = fetchRequest.fetchOffset;
    NSUInteger limit;
    NSUInteger newRows;//新增了多少条数据?

    if (offset>=kPageSize)
    {//可以加载前10条数据
        offset -= kPageSize;
        newRows = kPageSize;
        limit  =  [self.tableView numberOfRowsInSection:0] + newRows;
    }else
    {//前面不够一页，就显示所有数据
        newRows = offset;
        offset  = 0;
        limit   = 0;
    }
    
    [fetchRequest setFetchOffset:offset];
    [fetchRequest  setFetchLimit:limit];
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error])
    {//再次执行查询请求
        FDLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }else
    {
        if (newRows)
        {
            NSMutableArray *insertRows = [NSMutableArray arrayWithCapacity:newRows];
            for (NSUInteger i =0; i<newRows; i++)
            {
                [insertRows addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:insertRows withRowAnimation:UITableViewRowAnimationNone];//如何避免一闪?
            [self.tableView endUpdates];
        }else
        {
            FDLog(@"已经没有更多数据啦。");
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        [_refreshView endRefreshing];
                       
        if (newRows)
        {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newRows inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
                       
    });
    
}

/**
 *  下拉刷新，添加更多
 */
- (void)refreshLoadMoreMessage
{
    //联网刷新数据
    [self loadMoreMessage];
}




@end
