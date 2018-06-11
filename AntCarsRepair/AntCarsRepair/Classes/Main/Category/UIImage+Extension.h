//
//  UIImage+Extension.h
//  01-QQ聊天
//
//  Created by Apple on 15/6/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LRMergeImageDirection){
    LRMergeImageDirectionVertical,//垂直方向
    LRMergeImageDirectionHorizontal//水平方向
};

//typedef NS_ENUM(NSUInteger,LRCustomButtonLayoutType) {
//    LRCustomButtonLayoutImageTypeTop,
//    LRCustomButtonLayoutImageTypeLeft,
//    LRCustomButtonLayoutImageTypeBottom,
//    LRCustomButtonLayoutImageTypeRight
//};
@interface UIImage (Extension)
/**
 *  根据图片名字返回一张缩放过图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

- (UIImage *)scaleToSize:(CGSize)size;
//缩小一半
- (UIImage *)scaleToHalfSize;

//返回创建的二维码
+ (instancetype)createNonInterpolatedUIImageFormCIImage:(CIImage *)cimage withSize:(CGFloat)size;

///生成圆角图片
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

// UIColor 转UIImage
+ (instancetype)imageWithColor:(UIColor *)color;

///修改图片方向为正常方向
- (instancetype)changeOrientationToUp;
///修改图片方向为正常方向
+ (instancetype)fixOrientation:(UIImage *)aImage;
//压缩图片到指定大小KB size单位KB
- (NSData *)compresstoMaxDataSizeKBytes:(CGFloat)size;
//压缩图片到指定大小KB size单位KB
- (instancetype)compressImageToMaxDataSizeKBytes:(CGFloat)size;
///压缩图片到指定大小
+(instancetype)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
///压缩图片到指定大小
- (instancetype)scaleToKb:(NSInteger)kb;

//将传入的图片绘制在图片的正中央返回
- (instancetype)imageWithIcon:(UIImage *)icon radius:(CGFloat)radius;

//将传入的图片绘制成圆角
+ (instancetype)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

//将图片绘制成圆角
- (instancetype)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

-(UIImage*)imageWithCornerRadius:(CGFloat)radius;

//绘制一个虚线边框
+ (UIImage*)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

///截取scrollView所有内容
+ (instancetype)renderWithScrollView:(UIScrollView *)scrollView;

///截取指定view的内容
+ (instancetype)getImageWithView:(UIView *)view;

/**
 合并图片
 
 @param image1
 @param image2
 @param direction 方向
 @return 合并
 */
+ (instancetype)mergeImage:(UIImage *)image1 toImage:(UIImage *)image2 direction:(LRMergeImageDirection)direction;


@end
