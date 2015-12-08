//
//  Utils.m
//  YMApp
//
//  Created by yannis on 15/12/4.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(MBProgressHUD *)createHUD
{
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
//    HUD.labelText = @"正在加载数据";
    HUD.userInteractionEnabled = NO;
    [HUD show:YES];
    return HUD;
}

@end
