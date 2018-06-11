//
//  NSString+DateTime.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/10/20.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "NSString+DateTime.h"

@implementation NSString (DateTime)

//将服务器返回的时间戳转化成时间
+ (instancetype)getDateTimeFromTimestamp:(NSString *)timestamp{
    if (timestamp.length>10) {
        timestamp = [timestamp substringToIndex:10];
    }
    NSTimeInterval _interval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

//将服务器返回的时间戳转化成指定格式的时间
+ (instancetype)getDateTimeFromTimestamp:(NSString *)timestamp formatter:(NSString *)formatter{
    
    if (timestamp.length>10) {
        timestamp = [timestamp substringToIndex:10];
    }
    NSTimeInterval _interval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:formatter];
    return [objDateformat stringFromDate: date];
}

///传入时间戳返回多久前
+ (instancetype)getTimeOffWithTimestamp:(NSString *)timestamp{
    
    if (timestamp.length>10) {
        timestamp = [timestamp substringToIndex:10];
    }
    NSString *nowtimeSp = [NSString stringWithFormat:@"%lu", (NSInteger)[[NSDate date] timeIntervalSince1970]];
    if (nowtimeSp.length>10) {
        nowtimeSp = [nowtimeSp substringToIndex:10];
    }
    NSInteger timeOff = nowtimeSp.integerValue - timestamp.integerValue;
    //NSLog(@"timeSp:%@",timeSp); //时间戳的值时间戳转时间的方法
    NSInteger temp = 0;
    if (timeOff<60) {
        return [NSString stringWithFormat:@"刚刚"];
    }else if ((temp = timeOff/60)<60){
        return [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if ((temp = timeOff/(60*60))<24){
        return [NSString stringWithFormat:@"%ld小时前",temp];
    }else if((temp = timeOff/(24*60*60))<30){
        return [NSString stringWithFormat:@"%ld天前",temp];
    }else if (((temp = timeOff/(24*60*60*30)))<12){
        return [NSString stringWithFormat:@"%ld月前",temp];
    }else {
        temp = timeOff/(24*60*60*30*12);
        return [NSString stringWithFormat:@"%ld年前",temp];
    }
}




@end
