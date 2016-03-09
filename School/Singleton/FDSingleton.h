//
//  FDSingleton.h
//  School
//
//  Created by asus on 16/3/9.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#ifndef School_FDSingleton_h
#define School_FDSingleton_h

//.h文件调用
#define singleton_interface(class)       + (instancetype)share##class;
//.m文件调用
#define singleton_implementation(class)    static class *_instance;  \
+ (instancetype)allocWithZone:(struct _NSZone *)zone  \
{  \
    static dispatch_once_t one_taken;  \
    \
    dispatch_once(&one_taken, ^{  \
        _instance = [super allocWithZone:zone];  \
    });  \
    \
    return _instance;   \
}  \
\
+ (instancetype)share##class  \
{  \
    if (_instance == nil)  \
    {  \
        _instance = [[class alloc] init];  \
    }  \
    \
    return _instance;  \
}

#endif
