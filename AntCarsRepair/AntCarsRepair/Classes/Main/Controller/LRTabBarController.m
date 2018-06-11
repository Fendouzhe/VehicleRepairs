//
//  LRTabBarController.m
//  AntCarsRepair
//
//  Created by 雷路荣 on 2018/6/9.
//  Copyright © 2018年 广州宇中网络科技有限公司. All rights reserved.
//

#import "LRTabBarController.h"
#import "LRNavigationViewController.h"
#import "BXTabBar.h"
#import "LRHomeViewController.h"

@interface LRTabBarController ()<BXTabBarDelegate>

/** view */
@property (nonatomic, strong) BXTabBar *mytabbar;

/** 保存所有控制器对应按钮的内容（UITabBarItem）*/
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation LRTabBarController

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首页
    LRHomeViewController *homeVc = [[LRHomeViewController alloc] init];
    [self addChildVc:homeVc title:@"首页" image:@"home-n" selectedImage:@"home-s"];
    homeVc.navigationController.navigationBar.hidden = YES;
    
    //商城
    LRHomeViewController *mall = [[LRHomeViewController alloc] init];
    [self addChildVc:mall title:@"商城" image:@"shangcheng-n" selectedImage:@"shangcheng-s"];
    //资讯
    LRHomeViewController *guitai = [[LRHomeViewController alloc] init];
    [self addChildVc:guitai title:@"资讯" image:@"guitai-n" selectedImage:@"guitai-s"];
    //我的
    LRHomeViewController *mine = [[LRHomeViewController alloc] init];
    [self addChildVc:mine title:@"我的" image:@"fenxiao-n" selectedImage:@"fenxiao-s"];
    // 自定义tabBar
    [self setUpTabBar];
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar {
    BXTabBar *tabBar = [[BXTabBar alloc] init];
    // 存储UITabBarItem
    tabBar.items = self.items;
    tabBar.delegate = self;
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_background"]];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    //去掉tabBar分割线
    self.tabBar.backgroundImage = [[UIImage alloc] init];
    self.tabBar.shadowImage = [[UIImage alloc] init];
    self.mytabbar = tabBar;
//    //自定义Tabbar 显示消息红点
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabbarBageNoti:) name:ShowTabbarBageNotification object:nil];
//    //自定义Tabbar 移除消息红点
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabbarBageNoti:) name:RemoveTabbarBageNotification object:nil];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    //设置tabBarItem 的图片
    childVc.tabBarItem.image = [[[UIImage imageNamed:image] scaleToSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[[UIImage imageNamed:selectedImage] scaleToSize:CGSizeMake(25, 25)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabBarItem 的字体
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = KGlobalColor;
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = KMainColor;
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:childVc.tabBarItem];
    // 先给外面传进来的小控制器 包装 一个导航控制器
    LRNavigationViewController *nav = [[LRNavigationViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
    
}

#pragma mark - BXTabBarDelegate方法
// 监听tabBar上按钮的点击
- (void)tabBar:(BXTabBar *)tabBar didClickBtn:(NSInteger)index{
    [super setSelectedIndex:index];
    //self.selectedIndex = index;
}


/**
 *  让myTabBar选中对应的按钮
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    // 通过mytabbar的通知处理页面切换
    self.mytabbar.seletedIndex = selectedIndex;
}

#pragma mark -- 屏幕旋转相关 --
/**
 *
 *  @return 是否支持旋转
 */
-(BOOL)shouldAutorotate{
    //NSLog(@"======>> %d", __shouldAutorotate);
    return NO;//__shouldAutorotate;
}

/**
 *  适配旋转的类型
 *
 *  @return 类型
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
    //    if (!__shouldAutorotate) {
    //        return UIInterfaceOrientationMaskPortrait;
    //    }
    //    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
