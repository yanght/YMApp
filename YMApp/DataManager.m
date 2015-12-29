//
//  DataManager.m
//  YMApp
//
//  Created by yannis on 15/12/29.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+(instancetype)sharedManager
{
    static DataManager *shareDataManagerInstance=nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        shareDataManagerInstance=[[DataManager alloc]init];
    });
    return shareDataManagerInstance;
}


+ (void)checkNetWorkStatus{
    
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            
            NSLog(@"网络连接已断开，请检查您的网络！");
            
            return ;
        }
    }];
    
}

@end
