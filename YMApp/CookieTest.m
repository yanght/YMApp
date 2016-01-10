//
//  CookieTest.m
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CookieTest.h"

@implementation CookieTest
//第一次请求手动设置个cookie



-(void)test1{
    NSURL  *url =[NSURL URLWithString:@"http://weixin.m.yiguo.com/ProductOpt/GetProductInfo"];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    NSMutableDictionary *cookieProperties =[NSMutableDictionary dictionary];
    [cookieProperties   setObject:@"ygm_city" forKey:NSHTTPCookieName];
    [cookieProperties  setObject:@"{\"Id\":\"312d0556-0671-4f2e-8bac-7b8873b5a03a\",\"Code\":\"1\",\"Name\":\"%E4%B8%8A%E6%B5%B7\",\"Default\":0}" forKey:NSHTTPCookieValue];
    [cookieProperties   setObject:@".yiguo.com"  forKey:NSHTTPCookieDomain];
    [cookieProperties    setObject:@".yiguo.com" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/"    forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie  *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage  sharedHTTPCookieStorage]    setCookie:cookie];
    //[self.myWebView  loadRequest:request];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];

    
    
}



//第二次请求会自动带上cookie

-(void)test2
{
    NSURL  *url  =  [NSURL  URLWithString:@"http://weixin.m.yiguo.com/ProductOpt/GetProductInfo"];
    NSMutableURLRequest     *request    =  [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];

    //[self.mywebview2  loadRequest:request];
    
}

-(void)test3
{
    NSHTTPCookieStorage  *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookieArray  = [NSArray arrayWithArray:[cookieJar cookies]];
    for(id obj  in  cookieArray)
    {
        [cookieJar   deleteCookie:obj];
    }
}

@end
