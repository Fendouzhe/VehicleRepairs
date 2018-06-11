//
//  NSDictionary+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 16/9/14.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (instancetype)dictionaryWithJsonString:(NSString *)jsonString{
    
    if (!jsonString.length) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        LRLog(@"json解析失败：%@",error);
        return nil;
    }
    return dict;
}



- (NSString*)dictionaryToJson{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        LRLog(@"json解析失败：%@",parseError);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//防止奔溃
- (id)valueForUndefinedKey:(NSString *)key{
    return @"";
}



@end
