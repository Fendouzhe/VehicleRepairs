//
//  UIImageView+Extension.m
//  ShuangKuai-iOS
//
//  Created by 宇中 on 2016/10/25.
//  Copyright © 2016年 com.shuangkuaimai. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)addCornerWithRadius:(CGFloat)radius{
    self.image = [self.image imageAddCornerWithRadius:radius andSize:self.bounds.size];
}

@end
