//
//  DataManager.h
//  YMApp
//
//  Created by yannis on 15/12/29.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+(instancetype) sharedManager;


/*
 *检查网络状态
 */
+ (void)checkNetWorkStatus;


/*
 *brief post方法获取数据
 *param Parameters 参数字典集合
 *param suburl 接口地址
 *param block  数据回调block
 */
+ (void)postWithParameters:(NSDictionary *)Parameters
                    subUrl:(NSString *)suburl
                     block:(void (^)(NSDictionary *resultDic, NSError *error))block;

/*
 *brief get方法获取数据
 *param Parameters 参数字典集合
 *param suburl 接口地址
 *param block  数据回调block
 */
+ (void)getInfoWithSubUrl:(NSString *)subUrl
               parameters:(NSDictionary *)Parameters
                    block:(void (^)(id result, NSError *error))block;
/*
 *brief get方法获取数据
 *param suburl 接口地址
 *param block  数据回调block
 */
+ (void)getInfoWithSubUrl:(NSString *)subUrl
                    block:(void (^)(NSDictionary * resultDic, NSError *error))block;

/*
 *brief 取消网络请求
 */
+ (void)cancelRequest;


@end
