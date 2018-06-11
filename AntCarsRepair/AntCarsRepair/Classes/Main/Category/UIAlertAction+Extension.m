//
//  UIAlertAction+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/12/5.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "UIAlertAction+Extension.h"

@implementation UIAlertAction (Extension)

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    if (titleColor) {
        //if ([action valueForKey:@"titleTextColor"]) {
            [action setValue:titleColor forKey:@"titleTextColor"];
        //}
        
    }
    return action;
}

@end
