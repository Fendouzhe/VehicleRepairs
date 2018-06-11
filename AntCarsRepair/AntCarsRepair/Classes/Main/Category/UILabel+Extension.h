//
//  UILabel+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/3/24.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

///设置行间距
-(void)labelWithString:(NSString*)str lineSpace:(CGFloat)lineSpace font:(UIFont*)font textAlignment:(NSTextAlignment)alignment;

///设置字间距
-(void)labelWithString:(NSString*)str characterSpace:(CGFloat)characterSpace font:(UIFont*)font;

///设置原价标签
-(void)originPriceWithString:(NSString *)string color:(UIColor *)color;

///设置属性文本
- (void)attributeTextWithPre:(NSString *)pre preColor:(UIColor *)preColor text:(NSString *)text textColor:(UIColor *)textColor;

///设置属性文本
- (void)attributeTextWithPre:(NSString *)pre preColor:(UIColor *)preColor text:(NSString *)text textColor:(UIColor *)textColor last:(NSString *)last lastColor:(UIColor *)lastColor;

///设置属性文本
- (void)attributeTextWithPre:(NSString *)pre preColor:(UIColor *)preColor preFont:(UIFont *)preFont text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont;
@end
