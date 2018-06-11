//
//  LRMapNaviController.h
//  AntCarsRepair
//
//  Created by 雷路荣 on 2018/6/10.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRBaseViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface LRMapNaviController : LRBaseViewController

@property (nonatomic, strong)AMapNaviPoint *startPoint;

@property (nonatomic, strong)AMapNaviPoint *endPoint;

@end
