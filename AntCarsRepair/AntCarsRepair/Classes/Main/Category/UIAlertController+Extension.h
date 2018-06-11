//
//  UIAlertController+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/12/5.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extension)


+ (instancetype)alertControllerWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont message:(NSString *)message messageColor:(UIColor *)messageColor messageFont:(CGFloat)messageFont preferredStyle:(UIAlertControllerStyle)preferredStyle;

+ (instancetype)alertControllerWithTitle:(NSString *)title titleColor:(UIColor *)titleColor  message:(NSString *)message messageColor:(UIColor *)messageColor preferredStyle:(UIAlertControllerStyle)preferredStyle;

@end
