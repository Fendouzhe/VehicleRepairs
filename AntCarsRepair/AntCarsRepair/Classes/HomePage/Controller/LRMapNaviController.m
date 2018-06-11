//
//  LRMapNaviController.m
//  AntCarsRepair
//
//  Created by 雷路荣 on 2018/6/10.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRMapNaviController.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface LRMapNaviController ()<AMapNaviDriveManagerDelegate,AMapNaviDriveViewDelegate>

@property (nonatomic, strong)AMapNaviDriveView *driveView;

@end

@implementation LRMapNaviController

- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        [self.driveView setDelegate:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDriveManager];
    [self configDriveNavi];
    //进行路线规划
    [self calculateRoute];

}

- (void)configDriveNavi{
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
    [self.view addSubview:self.driveView];
}

- (void)initDriveManager{
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
}

//进行路线规划。
- (void)calculateRoute{
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[self.startPoint] endPoints:@[self.endPoint] wayPoints:nil drivingStrategy:AMapNaviDrivingStrategySingleDefault];
}
//当路线规划成功时，开启导航
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager{
    
    [[AMapNaviDriveManager sharedInstance] startEmulatorNavi];
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
    [self.driveView removeFromSuperview];
    self.driveView.delegate = nil;
}

@end
