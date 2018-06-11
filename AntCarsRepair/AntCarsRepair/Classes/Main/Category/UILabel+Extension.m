//
//  UILabel+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/3/24.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

-(void)labelWithString:(NSString*)str lineSpace:(CGFloat)lineSpace font:(UIFont*)font textAlignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font ? font : self.font, NSParagraphStyleAttributeName:paraStyle};//, NSKernAttributeName:@1.5f};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    self.attributedText = attributeStr;
}

-(void)labelWithString:(NSString*)str characterSpace:(CGFloat)characterSpace font:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font ? font : self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(characterSpace)};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    self.attributedText = attributeStr;
}

-(void)originPriceWithString:(NSString *)string color:(UIColor *)color {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSStrikethroughStyleAttributeName] = [NSNumber numberWithInteger:NSUnderlineStyleSingle];
    if (color) {
        dict[NSForegroundColorAttributeName] = color;
    }else{
        dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string attributes:dict];
    self.attributedText = attributeStr;
}

///设置属性文本
- (void)attributeTextWithPre:(NSString *)pre preColor:(UIColor *)preColor text:(NSString *)text textColor:(UIColor *)textColor{
    if (pre && text) {
        NSMutableAttributedString *muAttribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",pre,text] attributes:@{NSFontAttributeName:self.font}];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:preColor} range:NSMakeRange(0, pre.length)];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:textColor} range:NSMakeRange(pre.length, text.length)];
        self.attributedText = muAttribute;
    }
}


///设置属性文本
- (void)attributeTextWithPre:(NSString *)pre preColor:(UIColor *)preColor text:(NSString *)text textColor:(UIColor *)textColor last:(NSString *)last lastColor:(UIColor *)lastColor{
    if (pre && text && last) {
        NSMutableAttributedString *muAttribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",pre,text,last] attributes:@{NSFontAttributeName:self.font}];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:preColor} range:NSMakeRange(0, pre.length)];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:textColor} range:NSMakeRange(pre.length, text.length)];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:lastColor} range:NSMakeRange(pre.length + text.length, last.length)];
        self.attributedText = muAttribute;
    }
}

///设置属性文本
- (void)attributeTextWithPre:(NSString *)pre preColor:(UIColor *)preColor preFont:(UIFont *)preFont text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont{
    if (pre && text) {
        NSMutableAttributedString *muAttribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",pre,text] attributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor}];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:preColor} range:NSMakeRange(0, pre.length)];
        [muAttribute setAttributes:@{NSFontAttributeName:preFont} range:NSMakeRange(0, pre.length)];
        [muAttribute setAttributes:@{NSForegroundColorAttributeName:textColor} range:NSMakeRange(pre.length, text.length)];
        [muAttribute setAttributes:@{NSFontAttributeName:textFont} range:NSMakeRange(pre.length, text.length)];
        self.attributedText = muAttribute;
    }
}

@end
