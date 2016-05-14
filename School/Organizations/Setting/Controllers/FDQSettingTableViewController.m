//
//  FDQSettingTableViewController.m
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDQSettingTableViewController.h"
#import "FDQAboutMeController.h"
#import "FDApplyResumeInfoController.h"
#import "FDAboutSoftwareController.h"
#import "FDSettingModel.h"
#import "FDOrganization.h"


@interface FDQSettingTableViewController ()

@property (nonatomic, strong) NSArray *dataSources;   //cell需要显示的数据

@end



@implementation FDQSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    self.title = self.navigationController.tabBarItem.title;
}


/**
 *  cell数据懒加载
 */
- (NSArray *)dataSources
{
    if (!_dataSources) {
        FDSettingModel *applyResume = [[FDSettingModel alloc] init];
        FDSettingModel *clearMem = [[FDSettingModel alloc] init];
        FDSettingModel *aboutSoftware = [[FDSettingModel alloc] init];
        FDSettingModel *logout = [[FDSettingModel alloc] init];

        applyResume.title = @"应聘简历";
        clearMem.title = @"清除缓存";
        aboutSoftware.title = @"关于软件";
        logout.title = @"退出账号";
        
        NSArray *section1 = @[applyResume];
        NSArray *section2 = @[clearMem,aboutSoftware];
        NSArray *section3 = @[logout];
        _dataSources = @[section1, section2, section3];
    }
    
    return _dataSources;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dataSources[section];
    
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * const reuseId = @"settingReuseId";
    NSArray *array = self.dataSources[indexPath.section];
    FDSettingModel *model = array[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = model.title;
    if ((indexPath.section == self.dataSources.count-1)) {
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataSources[indexPath.section];
    FDSettingModel *model = array[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.section == self.dataSources.count-1)) {
        //退出账号
        [self logout];
    }else if ((indexPath.section == 0) && (indexPath.row == 0)){
        //应聘者简历
        [self applyResumeInfo];
    }else if ((indexPath.section == 1) && (indexPath.row == 0)){
         //清除缓存
        [self clearAllCache];
    }else if ((indexPath.section == 1) && (indexPath.row == 1)){
        //关于软件
        FDAboutSoftwareController *vc = [[FDAboutSoftwareController alloc] init];
        vc.title = model.title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/**
 *  关于自己显示
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
    if (section == 0) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"setting_head_bg.jpg" ofType:nil];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        [headerView.contentView addSubview:bgImageView];
        
        bgImageView.userInteractionEnabled = YES;
        
        UIButton *imageBtn = [[UIButton alloc] init];
        [bgImageView addSubview:imageBtn];
        [imageBtn addTarget:self action:@selector(editMyvCard) forControlEvents:UIControlEventTouchDown];
        if ([FDOrganization shareFDOrganization].photo) {
            [imageBtn setBackgroundImage:[UIImage imageWithData:[FDOrganization shareFDOrganization].photo] forState:UIControlStateNormal];
        }else{
            [imageBtn setBackgroundImage:[UIImage imageNamed:@"user_avatar_default"] forState:UIControlStateNormal];
        }
        
        
        UILabel *descLab = [[UILabel alloc] init];
        [bgImageView addSubview:descLab];
        imageBtn.layer.masksToBounds = YES;
        imageBtn.layer.cornerRadius = 40;
        if ([FDOrganization shareFDOrganization].nickname) {
            descLab.text = [FDOrganization shareFDOrganization].nickname;
        }else{
            descLab.text = [FDOrganization shareFDOrganization].account;
        }
        descLab.textColor = [UIColor grayColor];
        descLab.backgroundColor = [UIColor clearColor];
        descLab.font = [UIFont systemFontOfSize:15];
        descLab.textAlignment = NSTextAlignmentCenter;
        
        //添加约束
        //bgImageView
        [bgImageView autoPinEdgesToSuperviewEdges];
        
        //imageView
        [imageBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [imageBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:bgImageView];
        [imageBtn autoSetDimensionsToSize:CGSizeMake(80, 80)];
        
        
        //descLab
        [descLab autoSetDimension:ALDimensionHeight toSize:15];
        [descLab autoSetDimension:ALDimensionWidth toSize:200];
        [descLab autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:bgImageView];
        [descLab autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 19;
    if (section == 0) {
        height = 100;
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


#pragma mark - 公用方法
/**
 *  注销
 */
- (void)logout
{
    [[FDXMPPTool shareFDXMPPTool] xmppUserLogout];
}

/**
 *  进入查看应聘者简历
 */
- (void)applyResumeInfo
{
    FDApplyResumeInfoController *vc = [[FDApplyResumeInfoController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  清除缓存，包括所有聊天记录
 */
- (void)clearAllCache
{
    [self deleteAllRecordData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [FDMBProgressHUB showSuccess:@"已清除"];
    });
}

//删除聊天记录
- (void)deleteAllRecordData
{
    //关联上下文
    NSManagedObjectContext *context = [FDXMPPTool shareFDXMPPTool].msgStorage.mainThreadManagedObjectContext;
    
    //设置查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@", [FDUserInfo alloc].jidStr];
    
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

/**
 *  修改自己的vcard
 */
- (void)editMyvCard
{
    FDQAboutMeController *vc = [[FDQAboutMeController alloc] init];
    vc.title = @"我";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
