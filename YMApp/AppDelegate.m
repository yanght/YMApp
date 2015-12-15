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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
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
    
//    UINavigationController *listnav=[[UINavigationController alloc]initWithRootViewController:listcontroller];

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

    

    
    
//    listcontroller.title=@"分类";
//    [listcontroller.tabBarItem setImage:[[UIImage imageNamed:@"iconfont-fenlei"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [listcontroller.tabBarItem setSelectedImage:[[UIImage imageNamed:@"iconfont-fenlei-2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    UITabBarController *tabbarcontroller=[[UITabBarController alloc]init];
    
    NSArray *controllers=@[homenav,categorynav,searchnav,cartnav,membernav];
    
    [tabbarcontroller setViewControllers:controllers animated:YES];
    
    self.window.rootViewController=tabbarcontroller;
    
    
    //UITabBar *tablebar=tabbarcontroller.tabBar;
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:MAINCOLOR forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window makeKeyAndVisible];
    [self getYGSiteCookie];
    [self setNav];//修改程序中所有的显示的navigationbar的颜色，字体
    return YES;
}

-(void)getYGSiteCookie
{
    // 3.创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weixin.m.yiguo.com"]
                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                           timeoutInterval:3];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        NSLog(@"%@", cookie);
//    }
}

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
