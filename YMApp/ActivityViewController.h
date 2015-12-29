//
//  ActivityViewController.h
//  YMApp
//
//  Created by yannis on 15/12/19.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBanner.h"

@interface ActivityViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)HomeBanner *banner;

@property(nonatomic,strong) NSString *url;

@end
