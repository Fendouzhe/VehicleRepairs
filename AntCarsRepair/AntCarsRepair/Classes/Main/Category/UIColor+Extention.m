//
//  UIColor+Extention.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/10/25.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "UIColor+Extention.h"

@implementation UIColor (Extention)

///将16进制颜色转成UIColor
+ (instancetype)colorWithHexColorValue:(NSString *)ValueStr alpha:(CGFloat)alpha{
    
    NSString *cString = [[ValueStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if (cString.length < 6) {
        return [UIColor clearColor];
    }
    //判断前缀--截取十六进制数值
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }else if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if (cString.length != 6) {
        return [UIColor clearColor];
    }
    //获取rgb十六进制的值
    NSRange range = NSMakeRange(0, 2);
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(CGFloat)r/255.0 green:(CGFloat)g/255.0 blue:(CGFloat)b/255.0 alpha:alpha];
}

@end
