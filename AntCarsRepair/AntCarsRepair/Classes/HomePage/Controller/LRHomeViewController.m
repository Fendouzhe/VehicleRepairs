//
//  MYHomeViewController.m
//  AntCarsRepair
//
//  Created by 宇中 on 2018/6/7.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRHomeViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
// 自定义大头针 气泡
#import "CustomAnnotationView.h"
#import "CurrentLocationAnnotation.h"
#import "LRMapNaviController.h"


@interface LRHomeViewController ()<MAMapViewDelegate,AMapSearchDelegate>

// 地图
@property (nonatomic, strong) MAMapView            *mapView;
// 搜索引擎
@property (nonatomic, strong) AMapSearchAPI        *search;
// 自定义大头针
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
// 防止重复点击
@property (nonatomic, assign) BOOL                  isMapViewRegionChangedFromTableView;
// 是否正在定位
@property (nonatomic, assign) BOOL                  isLocated;
// 定位
@property (nonatomic, strong) UIButton             *locationBtn;
// 用户自定义大头针
@property (nonatomic, strong) UIImage              *imageLocated;
@property (nonatomic, strong) UIImage              *imageNotLocate;
// 选项卡
@property (nonatomic, strong) UISegmentedControl    *searchTypeSegment;
// 当前选中类型
@property (nonatomic, copy) NSString               *currentType;
// 当前类型下标
@property (nonatomic, copy) NSArray                *searchTypes;
// 坐标数据源
@property (nonatomic, strong) NSMutableArray *searchPoiArray;

@end

@implementation LRHomeViewController

#pragma mark - Life Cycle --

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSArray *viewControllers = self.navigationController.viewControllers;
    LRLog(@"self.navigationController.viewControllers = %@",viewControllers);
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
        LRLog(@"push");
    }else if([viewControllers indexOfObject:self] == NSNotFound){
        //当前视图控制器不在栈中，故为pop操作
        LRLog(@"pop");
        self.mapView.delegate = nil;
        [self.mapView removeFromSuperview];
        self.mapView = nil;
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initSearch];
    [self initMapView];
    [self initCenterView];
    [self initLocationButton];
    self.currentType = @"汽车维修";
    
}

#pragma mark - Utility

/**
 * @brief 根据中心点坐标来搜周边的POI.
 */
- (void)searchPoiWithCenterCoordinate:(CLLocationCoordinate2D )coord{
    
    AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
    
    request.radius   = 500;             /// 搜索范围
    request.types = self.currentType;   ///搜索类型
    request.sortrule = 0;               ///排序规则
    
    [self.search AMapPOIAroundSearch:request];
}

/**
 * @brief 逆地址编码查询接口
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate{
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}


#pragma mark - MapViewDelegate
/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    LRLog(@"%s",__func__);
    // 防止重复点击
    if (!self.isMapViewRegionChangedFromTableView && self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self actionSearchAroundAt:self.mapView.centerCoordinate];
    }
    self.isMapViewRegionChangedFromTableView = NO;
}

#pragma mark - userLocation
/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    LRLog(@"%s",__func__);
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0){
        return ;
    }
    
    // only the first locate used.
    if (!self.isLocated){
        self.isLocated = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        
        [self actionSearchAroundAt:userLocation.location.coordinate];
    }
}

/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView  didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated{
    LRLog(@"%s",__func__);
    if (mode == MAUserTrackingModeNone){
        [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    }else{
        [self.locationBtn setImage:self.imageLocated forState:UIControlStateNormal];
    }
}

/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    LRLog(@"error = %@",error);
}


/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    LRLog(@"%s",__func__);
    // 自定义坐标
    if ([annotation isKindOfClass:[CurrentLocationAnnotation class]])
    {
        static NSString *reuseIndetifier = @"CustomAnnotationView";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"HomePage_nearbyBikeRedPacket"];
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
        
    }
    return nil;
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    LRLog(@"%s",__func__);
    [self.mapView removeAnnotations:self.searchPoiArray];
    [self.searchPoiArray removeAllObjects];
    
    if (response.pois.count == 0){
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    LRLog(@" >>> %@",response.pois);
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        // 这里使用了自定义的坐标是为了区分系统坐标 不然蓝点会被替代
        CurrentLocationAnnotation *annotation = [[CurrentLocationAnnotation alloc] init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude)];
        [annotation setTitle:[NSString stringWithFormat:@"%@-%ld米", obj.name, (long)obj.distance]];
        [annotation setSubtitle:obj.address];
        
        [self.searchPoiArray addObject:annotation];
    }];
    
    [self showPOIAnnotations];
}


// 设置地图使其可以显示数组中所有的annotation
- (void)showPOIAnnotations{
    // 向地图窗口添加一组标注
    [self.mapView addAnnotations:self.searchPoiArray];
    
    if (self.searchPoiArray.count == 1){
        //如果数组中只有一个则直接设置地图中心为annotation的位置。
        //self.mapView.centerCoordinate = [(MAPointAnnotation *)self.searchPoiArray[0] coordinate];
        [self.mapView setZoomLevel:16 animated:NO];
    }
}


#pragma mark - Handle Action
- (void)actionSearchAroundAt:(CLLocationCoordinate2D)coordinate{
    
    [self searchReGeocodeWithCoordinate:coordinate];
    [self searchPoiWithCenterCoordinate:coordinate];
    
    [self centerAnnotationAnimimate];
}

// 定位
- (void)actionLocation{
    
    if (self.mapView.userTrackingMode == MAUserTrackingModeFollow){
        
        [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
        
    }else{
        
        [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            // 因为下面这句的动画有bug，所以要延迟0.5s执行，动画由上一句产生
            [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        });
    }
}


#pragma mark - Initialization
// 主视图
- (void)initMapView{
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), LRScreenHeight-TabBarHeight)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.mapView.zoomLevel = 17;              ///缩放级别（默认3-19，有室内地图时为3-20）
    self.mapView.showsCompass =NO;          /// 是否显示指南针
    self.mapView.showsScale = NO;           ///是否显示比例尺
    self.mapView.minZoomLevel =14;          /// 限制最小缩放级别
    self.mapView.showsUserLocation = YES;    ///是否显示用户位置
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //是否允许后台定位
    _mapView.allowsBackgroundLocationUpdates = YES;
    _mapView.showTraffic = YES;
    /// 去掉高德地图logo
    for (UIView *view in _mapView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    self.isLocated = NO;
}

- (void)initSearch{
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

// 自定义用户大头针
- (void)initCenterView{
    // 自己的坐标
    self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_wholeAnchor"]];
    self.centerAnnotationView.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.centerAnnotationView.bounds) / 2);
    
    [self.mapView addSubview:self.centerAnnotationView];
}

// 装载数据坐标
-(NSMutableArray *)searchPoiArray{
    if (!_searchPoiArray) {
        _searchPoiArray = [[NSMutableArray alloc]init];
    }
    return _searchPoiArray;
}


// 定位自己
- (void)initLocationButton{
    
    self.imageLocated = [UIImage imageNamed:@"gpssearchbutton"];
    self.imageNotLocate = [UIImage imageNamed:@"gpsnormal"];
    self.locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.mapView.bounds) - 40, CGRectGetHeight(self.mapView.bounds) - 50, 32, 32)];
    self.locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.locationBtn.backgroundColor = [UIColor whiteColor];
    
    self.locationBtn.layer.cornerRadius = 3;
    [self.locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    
    [self.view addSubview:self.locationBtn];
}


/* 移动窗口弹一下的动画 */
- (void)centerAnnotationAnimimate{
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y -= 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y += 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
}



@end
