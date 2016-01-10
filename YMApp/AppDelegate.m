//
//  AppDelegate.m
//  YMApp
//
//  Created by yannis on 15/11/2.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ProductListViewController.h"
#import "CategoryViewController.h"
#import "SearchViewController.h"
#import "CartViewController.h"
#import "MemberViewController.h"
#import "AFNetworking.h"
#import "CartService.h"
#import "CookieHelper.h"

@interface AppDelegate ()
{
    UITabBarItem *_cartTabBarItem;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.window makeKeyAndVisible];
    
    [self getYGSiteCookie];
    
    [self setNav];//修改程序中所有的显示的navigationbar的颜色，字体
    
    [self addNavAndTabbarController];
    
    [self addCartCountRefershNotification];
    
    return YES;
}

/**
 *  添加导航控制器和Tabbar控制器
 */
-(void)addNavAndTabbarController
{
    HomeViewController *homecontroller=[[HomeViewController alloc]init];
    CategoryViewController *categorycontroller=[[CategoryViewController alloc]init];
    SearchViewController *searchController=[[SearchViewController alloc
                                             ]init];
    CartViewController *cartController=[[CartViewController alloc]init];
    MemberViewController *membercontroller=[[MemberViewController alloc]init];
    
    
    UINavigationController *homenav=[[UINavigationController alloc]initWithRootViewController:homecontroller];
    UINavigationController *categorynav=[[UINavigationController alloc]initWithRootViewController:categorycontroller];
    UINavigationController *searchnav=[[UINavigationController alloc]initWithRootViewController:searchController];
    UINavigationController *cartnav=[[UINavigationController alloc]initWithRootViewController:cartController];
    UINavigationController *membernav=[[UINavigationController alloc]initWithRootViewController:membercontroller];

    
    homecontroller.title=@"首页";
    [homecontroller.tabBarItem setImage:[[UIImage imageNamed:@"iconfont-shouye"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homecontroller.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont-shouye-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    categorycontroller.title=@"分类";
    [categorycontroller.tabBarItem setImage:[[UIImage imageNamed:@"iconfont-fenlei"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [categorycontroller.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont-fenlei-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    searchController.title=@"搜索";
    [searchController.tabBarItem setImage:[[UIImage imageNamed:@"iconfont-sousuo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [searchController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont-sousuo-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    cartController.title=@"购物车";
    [cartController.tabBarItem setImage:[[UIImage imageNamed:@"iconfont-gouwuche"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [cartController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont-gouwuche-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    membercontroller.title=@"用户中心";
    [membercontroller.tabBarItem setImage:[[UIImage imageNamed:@"iconfont-yonghu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [membercontroller.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont-yonghu-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarController *tabbarcontroller=[[UITabBarController alloc]init];
    
    NSArray *controllers=@[homenav,categorynav,searchnav,cartnav,membernav];
    
    [tabbarcontroller setViewControllers:controllers animated:YES];
    
    self.window.rootViewController=tabbarcontroller;
    _cartTabBarItem=cartController.tabBarItem;
    
    CartService *svc=[[CartService alloc]init];
    NSInteger count= [svc getCartCount];
    if (count>0) {
        cartController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%ld",count];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:MAINCOLOR forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}

/**
 *  注册购物车数量通知
 */
-(void)addCartCountRefershNotification
{
    //注册购物车数量通知观察者
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(changeTabBarBadgeValue:) name:ChangeTabbarBadgeValueNotification object:nil];
}

/**
 *  购物车数量通知方法
 *
 *  @param sender 通知对象
 */
-(void)changeTabBarBadgeValue:(NSNotification *)sender
{
   NSString *cartCount=sender.userInfo[@"cartCount"];
    if ([cartCount integerValue]>0) {
    _cartTabBarItem.badgeValue=cartCount;
    }else
    {
    _cartTabBarItem.badgeValue=nil;
    }
}

//获取站点cookie
-(void)getYGSiteCookie
{
    // 3.创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weixin.m.yiguo.com"]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                           timeoutInterval:3];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
    
    CookieHelper *helper=[[CookieHelper alloc]init];
   // NSString *cartstr=[helper getCookieWithUrl:GET_COOKIE_URL cookieName:CART_COOKIE_NAME];
    NSString *cartstr=[[NSString alloc]init];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if (userDef) {
       cartstr= [userDef objectForKey:USERDEFAULT_CART_KEY];
    }
    
    NSMutableDictionary *cookieValues=[helper bulidCookieName:CART_COOKIE_NAME value:cartstr domain:COOKIE_DOMAIN];
    [helper addCookieWithUrl:GET_COOKIE_URL value:cookieValues];
}

/**
 *  设置导航栏样式
 */
- (void)setNav
{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    
    //bar.barTintColor =MAINCOLOR;
    
    //设置字体颜色
    
    bar.tintColor =MAINCOLOR;
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName :MAINCOLOR}];
    
    //或者用这个都行
    
    
    //    [bar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
