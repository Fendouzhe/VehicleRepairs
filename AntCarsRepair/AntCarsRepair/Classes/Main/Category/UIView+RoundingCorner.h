//
//  UIView+RoundingCorner.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/7/19.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundingCorner)

/**
 设置任意圆角
 
 @param corners 要设置的圆角位置集合
 @param radius 圆角半径
 */
- (void)roundingCornerWithCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 设置任意圆角 --- 性能优化
 
 @param corners 要设置的圆角位置集合
 @param radius 圆角半径
 */
- (void)rounderWithCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 设置圆角 --- 性能优化
 
 @param radius 圆角半径
 */
- (void)roundCornerWithRadius:(CGFloat)radius;

/**
 设置圆角阴影
 
 @param superview
 @param radius
 */
- (void)shadowWithSuperView:(UIView *)superview;

/**
 设置圆角阴影
 
 @param superview
 @param shadowOffset
 @param shadowOpacity
 @param shadowRadius
 */
- (void)shadowWithSuperView:(UIView *)superview shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;

@end
