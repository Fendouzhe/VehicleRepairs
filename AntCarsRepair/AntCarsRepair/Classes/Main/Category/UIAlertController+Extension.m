//
//  UIAlertController+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/12/5.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)

+ (instancetype)alertControllerWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont message:(NSString *)message messageColor:(UIColor *)messageColor messageFont:(CGFloat)messageFont preferredStyle:(UIAlertControllerStyle)preferredStyle{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    //修改title
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        if (titleFont > 0) {
            [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:titleFont] range:NSMakeRange(0, title.length)];
        }
        if (titleColor) {
            [alertControllerStr addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, title.length)];
        }
        //if ([alertVc valueForKey:@"attributedTitle"]) {
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
        //}
    }
    
    if (message) {
        //修改message
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        if (messageFont > 0) {
            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:messageFont] range:NSMakeRange(0, message.length)];
        }
        if (messageColor) {
            [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:messageColor range:NSMakeRange(0, message.length)];
        }
        
        //if ([alertVc valueForKey:@"attributedMessage"]) {
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
        //}
    }

    return alert;
}

+ (instancetype)alertControllerWithTitle:(NSString *)title titleColor:(UIColor *)titleColor  message:(NSString *)message messageColor:(UIColor *)messageColor preferredStyle:(UIAlertControllerStyle)preferredStyle{
    return [self alertControllerWithTitle:title titleColor:titleColor titleFont:0 message:message messageColor:messageColor messageFont:0 preferredStyle:preferredStyle];
}

@end
