//
//  Promotion.m
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "Promotion.h"

@implementation Promotion
-(Promotion *)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.PromotionsId=dic[@"PromotionsId"];
        self.PromotionsType=dic[@"PromotionsType"];
        self.PromotionsTitle=dic[@"PromotionsTitle"];
        self.PromotionsTag=dic[@"PromotionsTag"];
        self.SaleFlag=dic[@"SaleFlag"];
        self.SaleText=dic[@"SaleText"];
        self.LinkType=dic[@"LinkType"];
        self.LinkCode=dic[@"LinkCode"];
        self.LinkUrl=dic[@"LinkUrl"];
    }
    return self;
}
+(Promotion *)initWithDictionary:(NSDictionary *)dic
{
    Promotion *promotion=[[Promotion alloc]initWithDictionary:dic];
    return promotion;
}
@end
