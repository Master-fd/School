//
//  UIResponder+FDExtension.m
//  School
//
//  Created by asus on 16/3/19.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "UIResponder+FDExtension.h"

@implementation UIResponder (FDExtension)

- (void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithType:eventType userInfo:userInfo];
}
@end
