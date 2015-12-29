//
//  Utils.m
//  YMApp
//
//  Created by yannis on 15/12/4.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"

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
+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGSize size = CGSizeMake(screen_width-20,MAXFLOAT); //设置一个行高上限
    
    NSStringDrawingOptions options =
        NSStringDrawingTruncatesLastVisibleLine |
        NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize rtnsize=[string boundingRectWithSize:size options:options attributes:attribute context:nil].size;
    return rtnsize;
}
@end
