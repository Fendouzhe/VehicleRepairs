//
//  UIImage+Extension.m
//  01-QQ聊天
//
//  Created by Apple on 15/6/22.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
/**
 *  根据图片名字返回一张缩放过图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName{
    // 普通状态下的图片
    UIImage *normalImage = [UIImage imageNamed:imageName];
    CGFloat lefeCap = normalImage.size.width * 0.5;
    CGFloat topCap = normalImage.size.height * 0.5;
    
    /**
     *  lefeCapWith:左边多少距离不拉伸
     rightCapWith = width - leftCapWidth - 1 = 100 - 20 - 1 = 79
     topCapHeight:顶部多少距离不拉伸
     *  bottomCapHeight:底部多少距离不拉伸 = height - topCapWidth - 1 = 50 - 20 - 1 = 29
     */
    //        normalImage = [normalImage stretchableImageWithLeftCapWidth:lefeCap topCapHeight:topCap];
    // resizableImageWithCapInsets：ios5才出现方法
    return [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(topCap, lefeCap, topCap, lefeCap)];

}

- (UIImage *)scaleToSize:(CGSize)size{
    
    //UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);//让每一个点包含3个像素,更高清
    UIGraphicsBeginImageContextWithOptions(size, NO, 3);//让每一个点包含3个像素,更高清
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//缩小一半
- (UIImage *)scaleToHalfSize{
    return [self scaleToSize:CGSizeMake(self.size.width*0.5, self.size.height*0.5)];
}

//生成二维码图片
+ (instancetype)createNonInterpolatedUIImageFormCIImage:(CIImage *)cimage withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(cimage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent)) * 1.2;//乘以1.2 修复二维码识别不了
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:cimage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(cs);
    return [UIImage imageWithCGImage:scaledImage];
}

///生成圆角图片
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

// UIColor 转UIImage
+ (instancetype)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(instancetype)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    if (!image) {
        return image;
    }
    if (kb < 1) {
        return image;
    }
    kb *= 1024;
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    LRLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
    
}

- (instancetype)scaleToKb:(NSInteger)kb{
    
    if (!self) {
        return self;
    }
    if (kb < 1) {
        return self;
    }
    kb *= 1024;

    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    LRLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;

}

- (instancetype)imageWithIcon:(UIImage *)icon radius:(CGFloat)radius{
    //获取图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    //绘制图形
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGFloat width = MIN(self.size.width, self.size.height) * 0.3;
    
    //绘制白色边框背景图
    UIImage *borderImage = [UIImage imageWithColor:[UIColor whiteColor]];
    CGFloat borderWidth = width + 5;
    borderImage = [[borderImage scaleToSize:CGSizeMake(borderWidth, borderWidth)] roundedCornerImageWithCornerRadius:radius];
    [borderImage drawInRect:CGRectMake((self.size.width - borderWidth)*0.5, (self.size.height - borderWidth)*0.5, borderWidth, borderWidth)];
    
    //绘制图片圆角
    icon = [[icon scaleToSize:CGSizeMake(width, width)] roundedCornerImageWithCornerRadius:radius];
    [icon drawInRect:CGRectMake((self.size.width - width)*0.5, (self.size.height - width)*0.5, width, width)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight){
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (instancetype)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r {
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

- (instancetype)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius {
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    // 防止圆角半径小于0，或者大于宽/高中较小值的一半。
    if (cornerRadius < 0)
        cornerRadius = 0;
    else if (cornerRadius > MIN(w, h))
        cornerRadius = MIN(w, h) / 2.;
    
    UIImage *image = nil;
    CGRect imageFrame = CGRectMake(0., 0., w, h);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:cornerRadius] addClip];
    [self drawInRect:imageFrame];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage*)imageWithCornerRadius:(CGFloat)radius{
    
    CGRect rect = (CGRect){0.f,0.f,self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    //根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    [self drawInRect:rect];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+ (UIImage*)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [[UIColor clearColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = { 6, 1};
    CGContextSetLineDash(context, 0, lengths, 1);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, size.width, 0.0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    CGContextStrokePath(context);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

///截取scrollView所有内容
+ (instancetype)renderWithScrollView:(UIScrollView *)scrollView{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = scrollView.contentSize;
    /*
    if (scrollView.contentSize.width <= scrollView.frame.size.width) {
        size.width = scrollView.frame.size.width;
    }
    if (scrollView.contentSize.height <= scrollView.frame.size.height) {
        size.height = scrollView.frame.size.height;
    }
     */
    if (scrollView.contentSize.width == 0) {
        size.width = scrollView.frame.size.width;
    }
    if (scrollView.contentSize.height == 0) {
        size.height = scrollView.frame.size.height;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    //记录原来的值
    CGRect originFrame = scrollView.frame;
    CGPoint originContentOffSet = scrollView.contentOffset;
    //滚动值复位
    scrollView.contentOffset = CGPointZero;
    
    //重新设置scrollview的frame让其frame等于contentSize，然后再截取scrollview内所有内容
    scrollView.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y, size.width, size.height);
    //截图整个内容
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复原来的值
    scrollView.frame = originFrame;
    scrollView.contentOffset = originContentOffSet;
    
    UIGraphicsEndImageContext();
    
    return image ? image : nil;
    
}
///截取指定view的内容
+ (instancetype)getImageWithView:(UIView *)view{
    
    [view.superview layoutIfNeeded];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.size, NO, scale);
    //获取图形上下文
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    //作用：就是把View内部图层上的内容 绘制到 上下文当中
    //截取哪块取决于这个View
    [view.layer renderInContext:ctx];
    //回去绘制号的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}

//压缩图片到指定大小KB size单位KB
- (NSData *)compresstoMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    LRLog(@"dataKBytes = %lf",dataKBytes);
    if (size <= 0) {//不限制大小
        return data;
    }
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        if (size<1*1000) {
            maxQuality = maxQuality - 0.1f;
        }else if (size<2*1000) {
            maxQuality = maxQuality - 0.05f;
        }else{
            maxQuality = maxQuality - 0.01f;
        }
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
        LRLog(@"lastData = %lf dataKBytes = %lf",lastData,dataKBytes);
    }
    return data;
}

//压缩图片到指定大小KB size单位KB
- (instancetype)compressImageToMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    LRLog(@"dataKBytes = %lf",dataKBytes);
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        if (size<1*1000) {
            maxQuality = maxQuality - 0.1f;
        }else if (size<2*1000) {
            maxQuality = maxQuality - 0.05f;
        }else{
            maxQuality = maxQuality - 0.01f;
        }
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
        LRLog(@"lastData = %lf dataKBytes = %lf",lastData,dataKBytes);
    }
    UIImage *compressedImage = [UIImage imageWithData:data];
    return compressedImage;
}
///修改图片方向为正常方向
- (instancetype)changeOrientationToUp{
    /*
     typedef NS_ENUM(NSInteger, UIImageOrientation) {
     UIImageOrientationUp,            // default orientation
     UIImageOrientationDown,          // 180 deg rotation
     UIImageOrientationLeft,          // 90 deg CCW
     UIImageOrientationRight,         // 90 deg CW
     UIImageOrientationUpMirrored,    // as above but image mirrored along other axis. horizontal flip
     UIImageOrientationDownMirrored,  // horizontal flip
     UIImageOrientationLeftMirrored,  // vertical flip
     UIImageOrientationRightMirrored, // vertical flip
     };
     */
    UIImage *image = self;
    if (image.imageOrientation != UIImageOrientationUp) {//利用图片的宽高重新绘制一张
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawInRect:(CGRect){0,0,image.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = normalizedImage;
    }
    return image;
}
///修改图片方向为正常方向
+ (instancetype)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


/**
 合并图片

 @param image1
 @param image2
 @param direction 方向
 @return 合并
 */
+ (instancetype)mergeImage:(UIImage *)image1 toImage:(UIImage *)image2 direction:(LRMergeImageDirection)direction{
    /*
     UIGraphicsBeginImageContext(image1.size);
     // Draw image1
     [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
     // Draw image2
     [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
     */
    switch (direction) {
        case LRMergeImageDirectionVertical:
        {
            CGFloat width = MAX(image1.size.width, image2.size.width);
            CGFloat height = image1.size.height+image2.size.height;
            //LRLog(@"width = %lf",width);
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            // Draw image1
            [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
            // Draw image2
            [image2 drawInRect:CGRectMake(0, image1.size.height, image2.size.width, image2.size.height)];
        }
            break;
        case LRMergeImageDirectionHorizontal:
        {
            CGFloat width = image1.size.width+image2.size.width;
            CGFloat height = MAX(image1.size.height, image2.size.height);
            //LRLog(@"width = %lf",width);
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            // Draw image1
            [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
            // Draw image2
            [image2 drawInRect:CGRectMake(0, image1.size.width, image2.size.width, image2.size.height)];
        }
            break;
            
        default:
            break;
    }
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
