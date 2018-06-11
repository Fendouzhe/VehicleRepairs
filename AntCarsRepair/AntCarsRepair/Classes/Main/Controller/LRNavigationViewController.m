//
//  SMNavigationViewController.m
//  ShuangKuai-iOS
//
//  Created by yuzhongkeji on 15/11/9.
//  Copyright © 2015年 com.shuangkuaimai. All rights reserved.
//

#import "LRNavigationViewController.h"

@interface LRNavigationViewController ()<UIGestureRecognizerDelegate>

 @property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@end

@implementation LRNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"daohangtiao"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:KGlobalColor] forBarMetrics:UIBarMetricsDefault];
    //去掉navigationBar分割线
    //[[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    //设置标题属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:KNavTitleFont];
    //    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"注册" attributes:dict];
    [[UINavigationBar appearance] setTitleTextAttributes:dict];
    
    //设置返回箭头颜色
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置左右导航栏按钮文字 属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *attribute1 = @{NSFontAttributeName:KNavButtonTitleFont,NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSDictionary *attribute2 = @{NSFontAttributeName:KNavButtonTitleFont,NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [item setTitleTextAttributes:attribute1 forState:UIControlStateNormal];
    [item setTitleTextAttributes:attribute1 forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:attribute2 forState:UIControlStateDisabled];
    

//    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    //设置返回按钮<颜色
//    [[UINavigationBar appearance] setTintColor:KRedColorLight];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
//    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    
    
//    //获取系统自带滑动手势的target对象
//    id target = self.interactivePopGestureRecognizer.delegate;
//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
//    // 禁止使用系统自带的滑动手势
//    self.interactivePopGestureRecognizer.enabled = NO;// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
    
    //去掉底部分割线
//    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
//    [UINavigationBar appearance].translucent = YES;
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

//作用：拦截手势触发
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{  // 注意：只有非根控制器才有滑动返回功能，根控制器没有。  // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
//     CGPoint point = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.view];  //获取到滑动的点  判断是向右滑触发 其他不触发
//    if (self.childViewControllers.count == 1) {    // 表示用户在根控制器界面，就不需要触发滑动手势，
//        return NO;
//    }
//    if(point.x>0){
//        return YES;
//    }
//    return NO;
//}


//拦截push事件
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        //viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"fanhuihong" highImage:@"fanhuihong"];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];//[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"nav_back" highImage:@"nav_back"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark -- 屏幕旋转相关 -- UIViewController需要重写前面两方法
//控制是否支持横屏
-(BOOL)shouldAutorotate{
    // 通过找到当前的VC,返回相应的设置
    // 这里需要这个控制器重写这个方法
    return [[self.viewControllers lastObject] shouldAutorotate];
//    if ([self.viewControllers.lastObject isKindOfClass:[SMWebVideoPlayerController class]]) {//指定每个控制器横竖屏
//        return YES;
//    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}


@end
