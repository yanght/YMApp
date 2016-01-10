//
//  CookieHelper.m
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CookieHelper.h"

@implementation CookieHelper
    -(NSMutableDictionary *)bulidCoookie:(NSString *)name value:(NSString *)cookieValue domain:(NSString *)domain originURL:(NSString *)originURL cookiePath:(NSString *)cookiePath CookieVersion:(NSString *)cookieVersion
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:name forKey:NSHTTPCookieName];
        [dic setObject:name forKey:NSHTTPCookieName];
        [dic setObject:cookieValue forKey:NSHTTPCookieValue];
        [dic setObject:domain forKey:NSHTTPCookieDomain];
        [dic setObject:originURL forKey:NSHTTPCookieOriginURL];
        [dic setObject:cookiePath forKey:NSHTTPCookiePath];
        [dic setObject:cookieVersion forKey:NSHTTPCookieVersion];
    return dic;
}

-(NSMutableDictionary *)bulidCookieName:(NSString *)name value:(NSString *)cookieValue domain:(NSString *)domain
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:name forKey:NSHTTPCookieName];
    [dic setObject:name forKey:NSHTTPCookieName];
    [dic setObject:cookieValue forKey:NSHTTPCookieValue];
    [dic setObject:domain forKey:NSHTTPCookieDomain];
    [dic setObject:domain forKey:NSHTTPCookieOriginURL];
    [dic setObject:@"/" forKey:NSHTTPCookiePath];
    [dic setObject:@"0" forKey:NSHTTPCookieVersion];
    return dic;
}
-(void)addCookieWithUrl:(NSString *)urlStr value:(NSMutableDictionary *)cookieValue
{
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:url];
    NSHTTPCookie  *cookie = [NSHTTPCookie cookieWithProperties:cookieValue];
    [[NSHTTPCookieStorage  sharedHTTPCookieStorage] setCookie:cookie];
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
}
-(void)addCookie:(NSMutableDictionary *)cookieValue
{
    NSHTTPCookie  *cookie = [NSHTTPCookie cookieWithProperties:cookieValue];
    [[NSHTTPCookieStorage  sharedHTTPCookieStorage] setCookie:cookie];
}

-(void)clearAllCookie
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}

-(void)clearCookieWithUrl:(NSString *)url cookieName:(NSString *)name
{
    NSArray * cookArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:url]];
    for (NSHTTPCookie*cookie in cookArray)
    {
        if ([cookie.name isEqualToString:name])
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

-(NSString *)getCookieWithUrl:(NSString *)url cookieName:(NSString *)name
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:nil];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        if ([cookie.name isEqualToString:name]) {
            return cookie.value;
        }
    }
    return nil;
}

@end
