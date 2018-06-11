//
//  LRBaseViewController.h
//  AntCarsRepair
//
//  Created by 雷路荣 on 2018/6/9.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRBaseViewController : UIViewController

@property (nonatomic, copy)void (^block)(id data);

@end
