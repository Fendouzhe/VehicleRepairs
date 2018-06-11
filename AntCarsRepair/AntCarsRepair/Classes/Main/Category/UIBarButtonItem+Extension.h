//
//  UIBarButtonItem+Extension.h
//  微博00
//
//  Created by iOS on 15/9/21.
//  Copyright © 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage size:(CGSize)size secondItem:(BOOL)isSecond target:(id)target action:(SEL)action;

+ (instancetype)itemWithTitle:(NSString *)title size:(CGSize)size secondItem:(BOOL)isSecond target:(id)target action:(SEL)action;

@end
