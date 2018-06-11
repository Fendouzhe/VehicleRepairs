//
//  NSAttributedString+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2017/1/6.
//  Copyright © 2017年 com.shuangkuaimai. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

/**
 *  计算字符串实际占据的区域
 */
-(CGSize)attributeTextSizeWithMaxSize:(CGSize)maxSize{
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}

@end
