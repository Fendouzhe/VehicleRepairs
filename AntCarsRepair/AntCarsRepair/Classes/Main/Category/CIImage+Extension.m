//
//  CIImage+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 16/10/14.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "CIImage+Extension.h"

@implementation CIImage (Extension)

+ (instancetype)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}



@end
