//
//  FDGroupModel.m
//  School
//
//  Created by asus on 16/3/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDGroupModel.h"
#import "FDContactModel.h"

@implementation FDGroupModel

- (NSArray *)contacts
{
    if (!_contacts) {
        _contacts = [NSArray array];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            FDContactModel *model = [[FDContactModel alloc] init];
            model.userName = @"fei";
            model.nikeName = @"sdasd";
            model.account = @"155464";
            [arrayM addObject:model];
        }
        _contacts = arrayM;
    }
    
    return _contacts;
}

@end
