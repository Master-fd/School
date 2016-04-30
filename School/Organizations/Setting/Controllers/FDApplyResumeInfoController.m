//
//  FDApplyResumeInfoController.m
//  School
//
//  Created by asus on 16/4/28.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDApplyResumeInfoController.h"
#import "FDQResume.h"
#import "FDQResume+FDCoreDataProperties.h"
#import "FDResumeInfoCell.h"
#import "FDOrganization.h"
#import "FDQResumeController.h"
#import "FDApplyResumeInfoController+FDCoeData.h"
#import "NSObject+CoreDataHelper.h"


/********************************************
 收到的简历，应该保持在coredata数据库中，每个数据库保存一个resume字段和“colloct”字段需要的时候在取出来
 *****************************************/

@interface FDApplyResumeInfoController ()<UIActionSheetDelegate>

@end

@implementation FDApplyResumeInfoController

/**
 *  测试数据
 */
- (void)insertTestData
{
    for (int i=0; i<5; i++) {
        FDQResume *model = [FDQResume insertNewObjectInManagedObjectContext:self.managedObjectContext];
        model.jobTitle = [NSString stringWithFormat:@"高级工程师%d", i];
        model.department = [NSString stringWithFormat:@"社联部%d",i];
        model.jobContent = @"其实我直接的与傲视欧式不回宿舍；打你";
        model.jobPurposeOne = @"第几共收到";
        model.jobPurposeTwo = @"sdasd";
        model.email = @"1003768663@qq.com";
        model.phoneNumber = @"18898655184";
        model.major = @"电子信息科学与技术";
        model.name = @"master";
        model.specialtyOne = @"羽毛球";
        model.specialtyTwo = @"篮球";
        model.photo = [FDOrganization shareFDOrganization].photo;
        model.collect = i%2;
        
    }
     [self saveContext];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self insertTestData];
    
    [self setupNav];
    
    [self setupViews];
}

- (void)setupNav
{
    self.title = @"简历";
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteClick)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setupViews
{
    //一共多少条记录
    if (![FDQResume count]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"没有任何简历"];
        });
    }
    
    self.tableView.rowHeight = 60;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadMoreResume) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollToBottom:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FDQResume *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    FDResumeInfoCell *cell = [FDResumeInfoCell cellForTableView:tableView];
    
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDQResume *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    FDQResumeController *vc = [[FDQResumeController alloc] init];
    
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FDQResume *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [FDQResume removeObjectInManagedObjectContext:self.managedObjectContext atModel:model];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - uiactionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex) {
        case 0:
            [FDQResume removeAllObjectInManagedObjectContext:self.managedObjectContext];
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"没有收到任何简历"];
            });
            break;
            
        case 1:
            [FDQResume removeAllNonCollectObjectInManagedObjectContext:self.managedObjectContext withCollect:NO];
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"非收藏的已删除"];
            });

            break;
    

        default:
            break;
    }
}
#pragma mark - 公共方法
/**
 *  删除
 */
- (void)deleteClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"删除简历" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除所有" otherButtonTitles:@"删除非收藏", nil];
    
    [sheet showInView:self.tableView];
}
@end
