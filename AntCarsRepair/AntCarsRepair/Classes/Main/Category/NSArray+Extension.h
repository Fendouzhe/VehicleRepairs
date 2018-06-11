//
//  NSArray+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/11/15.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

///将json数组数据转成数组
+ (instancetype)arrayWithJsonString:(NSString *)jsonString;

///将json数组转成json数据
- (NSString*)arrayToJsonString;

@end
