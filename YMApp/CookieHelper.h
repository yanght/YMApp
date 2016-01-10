//
//  CookieHelper.h
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookieHelper : NSObject

-(void)addCookie:(NSMutableDictionary *)dic;

-(NSMutableDictionary *)bulidCoookie:(NSString *)name
              value:(NSString *)cookieValue
             domain:(NSString *)domain
          originURL:(NSString *)originURL
         cookiePath:(NSString *)cookiePath
      CookieVersion:(NSString *)cookieVersion;

-(NSMutableDictionary *)bulidCookieName:(NSString *)name
                              value:(NSString *)cookieValue
                             domain:(NSString *)domain;


-(void)addCookieWithUrl:(NSString *)url value:(NSMutableDictionary *)cookieValue;

-(void)clearAllCookie;

-(void)clearCookieWithUrl:(NSString *)url cookieName:(NSString *)name;

-(NSString *)getCookieWithUrl:(NSString *)url cookieName:(NSString *)name;

@end
