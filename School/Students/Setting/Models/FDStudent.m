//
//  FDStudent.m
//  School
//  将会显示在设置里面
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDStudent.h"
#import "XMPPvCardTemp.h"


@implementation FDStudent

singleton_implementation(FDStudent);

- (NSString *)account
{
    _account = [FDUserInfo shareFDUserInfo].account;
    return _account;
}

- (NSData *)photo
{
    _photo = self.myVcard.photo;
    return _photo;
}

- (NSString *)nickname
{
    _nickname = self.myVcard.nickname;
    return _nickname;
}

/**
 *  获取简历,视同logo字段来保存简历
 */
- (FDResume *)resume
{
    if (!_resume) {
        _resume = [[FDResume alloc] init];
        
        NSData *data = self.myVcard.logo;
        _resume = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return _resume;
}
/**
 *  自己vCard获取
 */
- (XMPPvCardTemp *)myVcard
{
    _myVcard = [FDXMPPTool shareFDXMPPTool].vCard.myvCardTemp;
    
    return _myVcard;
}

/**
 *  更新用户vcard信息
 */
- (void)updateMyvCard
{
    
    [[FDXMPPTool shareFDXMPPTool].vCard updateMyvCardTemp:[FDStudent shareFDStudent].myVcard];
}

//保存简历
- (void)saveResume
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.resume];

    self.myVcard.logo = data; //使用vcard的logo字段作为简历
    [self updateMyvCard];
}

@end
