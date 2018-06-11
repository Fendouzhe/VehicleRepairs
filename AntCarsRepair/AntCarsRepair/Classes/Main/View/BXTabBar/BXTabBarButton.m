//
//  BXTabBarButton.m
//  IrregularTabBar
//
//  Created by leilurong on 16/5/3.
//  Copyright © 2016年 leilurong. All rights reserved.
//

#import "BXTabBarButton.h"
#import "BXBadgeView.h"

@interface BXTabBarButton ()
/**
 *  提醒数字
 */
@property (strong, nonatomic) BXBadgeView *badgeView;
@end

@implementation BXTabBarButton
/**
 *  小红点
 */
- (BXBadgeView *)badgeView {
    if (!_badgeView) {
        BXBadgeView *badgeView = [[BXBadgeView alloc] init];
        [self addSubview:badgeView];
        self.badgeView = badgeView;
    }
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];//[UIFont boldSystemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    self.badgeView.badgeValue = item.badgeValue;
}
- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    self.badgeView.badgeValue = badgeValue;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.currentTitle.trimmingWhitespace.length) {
        // 文字位置
        self.titleLabel.x = 0;
        self.titleLabel.width = self.width;
        self.titleLabel.height = 16;
        self.titleLabel.y = self.height - self.titleLabel.height;
        
        // 图片位置
        self.imageView.width = self.currentImage.size.width;
        self.imageView.height = self.currentImage.size.height;
        self.imageView.x = (self.width - self.imageView.width) / 2;
        //self.imageView.y = self.titleLabel.y - self.imageView.height - 1;
        if (self.space>0) {
            self.imageView.y = self.titleLabel.y - self.imageView.height - self.space;
        }else{
            self.imageView.y = self.titleLabel.y - self.imageView.height - 1;
        }
        
    }else{
        // 图片位置
        self.imageView.width = self.currentImage.size.width;
        self.imageView.height = self.currentImage.size.height;
        self.imageView.x = (self.width - self.imageView.width) / 2;
        self.imageView.y = (self.height - self.imageView.height) / 2;
    }
    
    // 小红点位置
    self.badgeView.x = CGRectGetMaxX(self.imageView.frame) - 2;
    self.badgeView.y = 2;

}

- (void)setHighlighted:(BOOL)highlighted {}

@end
