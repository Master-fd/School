//
//  FDContactsViewController.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDBaseContactsController.h"
#import "FDContactViewCell.h"
#import "FDContactModel.h"
#import "FDChatController.h"
#import "FDAddFriendViewController.h"
#import "FDBaseContactsController+CoreDataExtension.h"
#import "XMPPvCardTemp.h"


@interface FDBaseContactsController ()



@end

@implementation FDBaseContactsController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];

    [self setupViews];
}

- (void)setupViews
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.rowHeight = 50;
    self.tableView.sectionFooterHeight = 1;   //section之间距离
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:kNotificationNewMsgDidRead object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:kNotificationReciveNewMsg object:nil];
}


/**
 *  设置导航栏
 */
- (void)setupNav
{
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ff_IconAdd"] style:UIBarButtonItemStyleDone target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = self.navigationController.tabBarItem.title;
}
/**
 *  跳转到添加好友界面
 */
- (void)addFriend
{
    FDAddFriendViewController *vc = [[FDAddFriendViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  刷新tableview
 */
- (void)refreshTableView
{
    [[FDXMPPTool shareFDXMPPTool] xmppFetchBuddyFromServer:[FDUserInfo shareFDUserInfo].jidStr];
    [self.refreshControl endRefreshing];
    
}

#pragma mark - Table view data source
//返回组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchedResultsController sections] count];
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

//设置cell数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取联系人模型数据
    FDContactModel *contactModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //获取联系人vcard信息
    XMPPvCardTemp *vCard = [[FDXMPPTool shareFDXMPPTool] xmppvCardTempForJIDStr:contactModel.jidStr];
    FDContactViewCell *cell = [FDContactViewCell contactViewCellWithTableView:tableView];
 
    //设置数据
    cell.contactModel = contactModel;
    cell.vCard = vCard;
    
    return cell;
}
//cell被点击,联系人被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    FDContactModel *contactModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //push到聊天界面
    FDChatController *vc = [[FDChatController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = contactModel.nickname;
    vc.nickname = contactModel.nickname;
    vc.jidStr = contactModel.jidStr;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  //取消选中状态
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString * const headViewId = @"headViewReuseId";
    
    id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    if ([[self.fetchedResultsController sections] count]) {
        sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    }
    
    UITableViewHeaderFooterView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewId];
    if (!headview) {
        headview = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headViewId];
    }
    headview.contentView.backgroundColor = [UIColor clearColor];
    
    UILabel *nameLab = [[UILabel alloc] init];
    [headview.contentView addSubview:nameLab];
    nameLab.text = sectionInfo.name;
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textColor = [UIColor grayColor];
    nameLab.alpha = 0.9;
    nameLab.font = [UIFont systemFontOfSize:14];
    [nameLab sizeToFit];
    [nameLab autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 0) excludingEdge:ALEdgeRight];
    
    return headview;
}



//允许cell编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //获取这一行对应用户的jid
        FDContactModel *contactModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
        XMPPJID *friendJid = [XMPPJID jidWithString:contactModel.jidStr];
        
        //删除数据库对应聊天数据
        [self deleteRecordDataInJidStr:contactModel.jidStr];
        //删除好友
        [[FDXMPPTool shareFDXMPPTool].roster removeUser:friendJid];
       
    }
        
}


/**
 *  删除指定人的聊天数据
 */
- (void)deleteRecordDataInJidStr:(NSString *)jidStr
{
    //关联上下文
    NSManagedObjectContext *context = [FDXMPPTool shareFDXMPPTool].msgStorage.mainThreadManagedObjectContext;
    
    //设置查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@", [FDUserInfo alloc].jidStr, jidStr];
    
    //关联表XMPPUserCoreDataStorageObject
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    request.predicate = predicate;
    
    //查找
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error) {
        FDLog(@"%@", error);
        return;
    }
    
    for (NSManagedObject *object in results) {
        [context deleteObject:object];  //删除
    }

    [context save:nil];
}



@end



