//
//  UIView+RoundingCorner.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/7/19.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "UIView+RoundingCorner.h"

@implementation UIView (RoundingCorner)


/**
 设置任意圆角

 @param corners 要设置的圆角位置集合
 @param radius 圆角半径
 */
- (void)roundingCornerWithCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    
    ///解决masonry布局获取不了正确的frame
    [self.superview layoutIfNeeded];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

/**
 设置任意圆角 --- 性能优化
 
 @param corners 要设置的圆角位置集合
 @param radius 圆角半径
 */
- (void)rounderWithCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    
    ///解决masonry布局获取不了正确的frame
    [self.superview layoutIfNeeded];
    
    //绘制圆/圆弧---适用于全圆
    //UIBezierPath *maskPath = [UIBezierPath bezierPathWithArcCenter:self.bounds radius:iconWidth*0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    //矩形---圆角
    //UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.iconImage.width*0.5];
    //宽高相等为全圆，不等为椭圆
    //UIBezierPath *maskPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

/**
 设置圆角 --- 性能优化
 
 @param radius 圆角半径
 */
- (void)roundCornerWithRadius:(CGFloat)radius{
    
    [self rounderWithCorners:UIRectCornerAllCorners radius:radius];
    
}
 
/**
 设置圆角阴影
 
 @param superview
 @param radius
 */
- (void)shadowWithSuperView:(UIView *)superview{
    
    ///解决masonry布局获取不了正确的frame
    [self.superview layoutIfNeeded];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectInset(self.frame, 1, 1);//self.frame;
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = 0.3;
    layer.cornerRadius = self.layer.cornerRadius;//圆角半径
    layer.shadowRadius = 3;//阴影半径，默认3
    [superview.layer addSublayer:layer];
    //要放到imagView下方
    [superview.layer insertSublayer:layer below:self.layer];
}


/**
 设置圆角阴影
 
 @param superview
 @param shadowOffset
 @param shadowOpacity
 @param shadowRadius
 */
- (void)shadowWithSuperView:(UIView *)superview shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius{
    
    ///解决masonry布局获取不了正确的frame
    [self.superview layoutIfNeeded];
    
    CALayer *layer = [CALayer layer];
    layer.frame = self.frame;
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = shadowOffset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    layer.shadowOpacity = shadowOpacity;//阴影透明度0-1，默认0
    layer.shadowRadius = shadowRadius;//阴影半径，默认3
    layer.cornerRadius = self.layer.cornerRadius;//圆角半径
    [superview.layer addSublayer:layer];
    //要放到imagView下方
    [superview.layer insertSublayer:layer below:self.layer];
}

@end
