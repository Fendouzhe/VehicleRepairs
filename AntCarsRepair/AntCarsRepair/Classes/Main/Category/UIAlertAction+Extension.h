//
//  UIAlertAction+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/12/5.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertAction (Extension)

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor style:(UIAlertActionStyle)style handler:(void (^ )(UIAlertAction *action))handler;

@end
