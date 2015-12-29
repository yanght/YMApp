//
//  ProductSpec.m
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductSpec.h"

@implementation ProductSpec
-(ProductSpec *)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.CommodityId=dic[@"CommodityId"];
        self.CommodityName=dic[@"CommodityName"];
        self.CommodityCode=dic[@"CommodityCode"];
        self.Spec=dic[@"Spec"];
    }
    return self;
}

+(ProductSpec *)initWithDictionary:(NSDictionary *)dic
{
    ProductSpec *spec=[[ProductSpec alloc]initWithDictionary:dic];
    return spec;
}
@end
