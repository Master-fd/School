//
//  FDJobInfoController.m
//  School
//
//  Created by asus on 16/4/24.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDJobInfoController.h"
#import "FDJobButtonView.h"
#import "FDJobDescribeViewCell.h"
#import "FDJobInfoViewCell.h"
#import "FDJobButtonView.h"
#import "FDChatController.h"
#import "FDContactModel.h"
#import "FDJobModel.h"
#import "FDResumejobModel.h"
#import "FDStudent.h"
#import "XMPPvCardTemp.h"

@interface FDJobInfoController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FDJobButtonView *jobButtonView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FDJobInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self setupContraints];
}

- (void)setupViews
{
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _jobButtonView = [[FDJobButtonView alloc] init];
    [self.view addSubview:_jobButtonView];
    __weak typeof(self) _weakself = self;
    _jobButtonView.sendResumeToXmppJidStrBlock = ^{
        //发送简历, 将应聘记录通过字典保存到plist起来

        NSDictionary *applyInfoDic = @{@"jidStr" : _weakself.contactModel.jidStr,
                                       @"jobName" : _weakself.jobModel.jobName,
                                       @"organization" : _weakself.jobModel.organization,
                                       @"department" : _weakself.jobModel.department,
                                       @"photo" : _weakself.jobModel.icon
                                       };
        //发送简历，同时保存一条信息到plist,保存
        [_weakself saveApplyInfoWithPlist:applyInfoDic];

    };
    _jobButtonView.sendMessageToXmppJidStrBlock = ^{
        //push到聊天界面
        FDChatController *vc = [[FDChatController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = _weakself.contactModel.nickname;
        vc.jidStr = _weakself.contactModel.jidStr;
        vc.nickname = _weakself.contactModel.nickname;  //备注
        [_weakself.navigationController pushViewController:vc animated:YES];
        
    };
    if (self.iShideBar) {
        _jobButtonView.sendMessageBtn.hidden = YES;
        _jobButtonView.sendResumeBtn.hidden = YES;
    }else{
        _jobButtonView.sendMessageBtn.hidden = NO;
        _jobButtonView.sendResumeBtn.hidden = NO;
    }
    
    if (!self.jobModel) {  //job模型为空,不显示，提示没有这个信息
        self.tableView.hidden = YES;
        _jobButtonView.hidden = YES;
        self.view.backgroundColor = [UIColor whiteColor];
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"该招聘信息已过期"];
        });
    }
}

- (void)setupContraints
{
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [_tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_jobButtonView];
    
    [_jobButtonView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_jobButtonView autoSetDimension:ALDimensionHeight toSize:50];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        FDJobInfoViewCell *cell = [FDJobInfoViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.jobModel;
        return cell;
    }else if (indexPath.section == 1){
        FDJobDescribeViewCell *cell = [FDJobDescribeViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置数据
        cell.model = self.jobModel;
        return cell;
    }
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [FDJobInfoViewCell height];
    }else if (indexPath.section == 1){
        return [FDJobDescribeViewCell height];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else if (section == 1) {
        return 0;
    }
    return 0;
}

#pragma mark - 公共方法
/**
 *  发送简历,添加一条应聘信息到plist
 */
- (BOOL)saveApplyInfoWithPlist:(NSDictionary *)dataDic
{
    // 0 在线。1 离开 2离线
    if ([self.contactModel.sectionNum intValue]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [FDMBProgressHUB showError:@"好友不在线，不能简历"];
        });
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:kMyApplyInfoPlistPath]) {  //文件不存在，则创建
        [fileManager createFileAtPath:kMyApplyInfoPlistPath contents:nil attributes:nil];
    }
    //先读取文件里面的内容
    NSArray *arrayM = [NSArray arrayWithContentsOfFile:kMyApplyInfoPlistPath];
    NSMutableArray *data = [NSMutableArray arrayWithArray:arrayM];
    //遍历查看这条信息是否已经应聘过了
    for (NSDictionary *dic in data) {
        if ([dic[@"jobName"] isEqualToString:dataDic[@"jobName"]]
            && [dic[@"organization"] isEqualToString:dataDic[@"organization"]]
            && [dic[@"department"] isEqualToString:dataDic[@"department"]]) {
            //已经应聘过了
            //这条信息已经有记录，说明应聘过了
            dispatch_async(dispatch_get_main_queue(), ^{
                [FDMBProgressHUB showError:@"不能重复应聘"];
            });
            return NO;
        }
    }
    
    [data addObject:dataDic];//添加一条数据保存

    [data writeToFile:kMyApplyInfoPlistPath atomically:YES];
    
    //发送简历
    [self sendMyResumeToHr:self.contactModel.jidStr];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [FDMBProgressHUB showSuccess:@"简历发送成功"];
    });
    return YES;
}

/**
 *  联网发送简历,自己的简历采用NSData的方式保存在myVcard的logo字段中,就是取这个字段发送出去
 *  jidStr：好友的jidstr
 */
- (void)sendMyResumeToHr:(NSString *)jidStr
{
    //发送chat信息,固定格式
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:jidStr]];
    
    //拼接数据 为BodyResume标识符，为了接收到的时候，识别出来信息内容是“BodyResume”，就知道是简历，可以拦截保存起来
    [msg addBody:kBodyResume];

    //获取自己的简历,logo字段就是简历
    NSData *resume = [FDStudent shareFDStudent].myVcard.logo;
    
    //转换成base64的编码
    NSString *base64Str = [resume base64EncodedStringWithOptions:0];
    
    //设置节点内容
    XMPPElement *attachment = [XMPPElement elementWithName:@"resume" stringValue:base64Str];
    
    //添加子节点
    [msg addChild:attachment];
    
    //发送数据
    [[FDXMPPTool shareFDXMPPTool].xmppStream sendElement:msg];
    
}


@end





