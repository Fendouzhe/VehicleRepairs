//
//  NSDictionary+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 16/9/14.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

///将json字典数据转成数组
+ (instancetype)dictionaryWithJsonString:(NSString *)jsonString;

///将json字典转成json数据
- (NSString*)dictionaryToJson;



@end
