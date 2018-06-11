//
//  UIBarButtonItem+Extension.m
//  微博00
//
//  Created by iOS on 15/9/21.
//  Copyright © 2015年 iOS. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"


@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    CGFloat width = 32;
//    [btn setBackgroundImage:[[UIImage imageNamed:image] scaleToSize:CGSizeMake(width, width)] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[[UIImage imageNamed:highImage] scaleToSize:CGSizeMake(width, width)] forState:UIControlStateHighlighted];

    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highImage) {
        [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    //设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];;
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    if (highImage.length) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = KNavButtonTitleFont;
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(60, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KNavButtonTitleFont} context:nil].size;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.size = CGSizeMake([UIImage imageNamed:image].size.width+titleSize.width+5, 28*LRMatch);//CGSizeMake(45*LRMatch, 28*LRMatch);
    //[btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage size:(CGSize)size secondItem:(BOOL)isSecond target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isSecond) {
        button.size = CGSizeMake(size.width+20, size.height);
    }else{
        button.size = CGSizeMake(size.width, size.height);
    }
    [button setImage:[[UIImage imageNamed:image] scaleToSize:size] forState:UIControlStateNormal];
    if (highImage.length) {
        [button setImage:[[UIImage imageNamed:highImage] scaleToSize:size] forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)itemWithTitle:(NSString *)title size:(CGSize)size secondItem:(BOOL)isSecond target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isSecond) {
        button.size = CGSizeMake(size.width+20, size.height);
    }else{
        button.size = CGSizeMake(size.width, size.height);
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
