//
//  NSString+DateTime.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/10/20.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateTime)

//将服务器返回的时间戳转化成时间
+ (instancetype)getDateTimeFromTimestamp:(NSString *)timestamp;

//将服务器返回的时间戳转化成指定格式的时间
+ (instancetype)getDateTimeFromTimestamp:(NSString *)timestamp formatter:(NSString *)formatter;

///传入时间戳返回多久前
+ (instancetype)getTimeOffWithTimestamp:(NSString *)timestamp;

@end
