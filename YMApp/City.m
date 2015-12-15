//
//  City.m
//  YMApp
//
//  Created by yannis on 15/12/15.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "City.h"

@implementation City

-(City *)initWitgDic:(NSDictionary *)dic
{
    if(self=[super init])
    {
        self.Id=dic[@"Id"];
        self.Name=dic[@"Name"];
        self.Code=dic[@"Code"];
        self.PY=dic[@"PY"];
    }
    return self;
}

+(City *)initWitgDic:(NSDictionary *)dic
{
    City *city=[[City alloc]initWitgDic:dic];
    return city;
}
@end
