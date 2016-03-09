//
//  FDXMPPTool.h
//  School
//
//  Created by asus on 16/3/8.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDXMPPTool : NSObject

singleton_interface(FDXMPPTool);
/**
 *  当前是否是注册操作
 */
@property (nonatomic, assign, getter=isRegisterOperation) BOOL registerOperation;


@end
