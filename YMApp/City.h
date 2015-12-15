//
//  City.h
//  YMApp
//
//  Created by yannis on 15/12/15.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property(nonatomic,strong) NSString *Id;

@property(nonatomic,strong) NSString *Name;

@property(nonatomic,strong) NSString *Code;

@property(nonatomic,strong) NSString *PY;

-(City *)initWitgDic:(NSDictionary *)dic;

+(City *)initWitgDic:(NSDictionary *)dic;

@end
