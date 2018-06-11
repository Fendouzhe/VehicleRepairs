//
//  CIImage+Extension.h
//  ShuangKuai-iOS
//
//  Created by 宇中 on 16/10/14.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface CIImage (Extension)

///生成二维码
+ (instancetype)createQRForString:(NSString *)qrString;

@end
