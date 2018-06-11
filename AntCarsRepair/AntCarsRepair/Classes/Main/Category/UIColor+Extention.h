//
//  UIColor+Extention.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/10/25.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extention)

///将16进制颜色值转成UIColor
+ (instancetype)colorWithHexColorValue:(NSString *)ValueStr alpha:(CGFloat)alpha;

@end
