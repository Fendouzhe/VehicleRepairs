//
//  NSArray+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/11/15.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

+ (instancetype)arrayWithJsonString:(NSString *)jsonString{
    if (!jsonString.length) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        LRLog(@"json解析失败：%@",error);
        return nil;
    }
    return arr;
}

- (NSString*)arrayToJsonString{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        LRLog(@"json解析失败：%@",parseError);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
