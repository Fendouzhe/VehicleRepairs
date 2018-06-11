//
//  NSString+Encode.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/10/19.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

- (instancetype)encode{
    NSString *string = self;
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    string = [string stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    string = [string stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    string = [string stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    string = [string stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    //解决NSString 转NSURL 为空
    //string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return string;
}

- (instancetype)dcode{
    NSString *string = self;
    string = [string stringByReplacingOccurrencesOfString:@"%3A" withString:@":"];
    string = [string stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
    string = [string stringByReplacingOccurrencesOfString:@"%3F" withString:@"?"];
    string = [string stringByReplacingOccurrencesOfString:@"%3D" withString:@"="];
    string = [string stringByReplacingOccurrencesOfString:@"%26" withString:@"&"];
    return string;
}

@end
