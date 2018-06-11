//
//  NSURL+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/3/30.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "NSURL+Extension.h"

@implementation NSURL (Extension)
///类被加载的时候
+(void)load{
    
    Method method1 = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method method2 = class_getClassMethod([NSURL class], @selector(LR_URLWithString:));
    //调用method1就会调用method2，调用method2就会调用method1
    method_exchangeImplementations(method1, method2);
}
///系统方法
//+ (instancetype)URLWithString:(NSString *)URLString{
//    NSURL *url = [[NSURL alloc] initWithString:URLString];
//    if (url == nil) {
//        LRLog(@"url为空");
//    }
//    return url;
//}

///自定义方法
+ (instancetype)LR_URLWithString:(NSString *)URLString{
    //需要调用自己，目的走到系统的方法
    NSURL *url = [NSURL LR_URLWithString:URLString];
    if (url == nil) {
        LRLog(@"url为空");
    }
    return url;
}


@end
