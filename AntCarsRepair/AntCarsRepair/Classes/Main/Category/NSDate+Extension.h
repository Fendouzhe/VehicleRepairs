//
//  NSDate+Extension.h
//  01 网易彩票
//
//  Created by 雷路荣 on 15/11/12.
//  Copyright © 2015年 leilurong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  传入时间及格式转换为字符串
 *
 *  @param date     传入的时间
 *  @param formatter 时间格式
 *
 *  @return 返回字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormatter:(NSString *)formatter;

- (NSString *)stringFromDateFormatter:(NSString *)formatter;
/**
 *  传入时间字符串及格式转换为时间
 *
 *  @param text     传入的时间字符串
 *  @param formatter 时间格式
 *
 *  @return 返回时间
 */
+ (instancetype)dateFromString:(NSString *)text withDateFormatter:(NSString *)formatter;

//获取当前的时间
+(NSString*)getCurrentTimes;
///获取当前时间字符串
+(NSString *)getNowTimeTimestamp;
///获取当前时间戳有两种方法(以秒为单位)
+(NSString *)getNowTimeTimestamp2;
///获取当前时间戳 （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3;

@end
