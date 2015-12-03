
//
//  Product.m
//  YMApp
//
//  Created by yannis on 15/11/22.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "Product.h"

@implementation Product

-(Product *)initWithDictionary:(NSDictionary *)dic
{
    if(self=[super init])
    {
        self.CommodityId=dic[@"CommodityId"];
        self.CommodityCode=dic[@"CommodityCode"];
        self.CommodityName=dic[@"CommodityName"];
        self.CommodityAmount=dic[@"CommodityAmount"];
        self.CommodityType=dic[@"CommodityType"];
        self.OriginalPrice=dic[@"OriginalPrice"];
        self.CommodityPrice=dic[@"CommodityPrice"];
        self.CommodityTotalPrice=dic[@"CommodityTotalPrice"];
        self.State=dic[@"State"];
        self.DeliveryArea=dic[@"DeliveryArea"];
        self.Spec=dic[@"Spec"];
        self.SpecId=dic[@"SpecId"];
        self.BrandName=dic[@"BrandName"];
        self.PlaceOfOrigin=dic[@"PlaceOfOrigin"];
        self.Pictures=dic[@"Pictures"];
        self.SmallPic=dic[@"SmallPic"];
        self.Speces=dic[@"Speces"];
        self.Description=dic[@"Description"];
        self.IsFreedom=dic[@"IsFreedom"];
        self.IsFreedom=dic[@"IsFreedom"];
        self.IsGift=dic[@"IsGift"];
        self.CouponCode=dic[@"CouponCode"];
        self.GiftRuleId=dic[@"GiftRuleId"];
        self.GiftRuleType=dic[@"GiftRuleType"];
        self.OrderDetailsType=dic[@"OrderDetailsType"];
        self.UsePoint=dic[@"UsePoint"];
        self.PriceType=dic[@"PriceType"];
        self.ShowOriginalPrice=dic[@"ShowOriginalPrice"];
        self.CommodityDeliveryDate=dic[@"CommodityDeliveryDate"];
        self.CommodityDeliveryTime=dic[@"CommodityDeliveryTime"];
        self.DefaultAreaCode=dic[@"DefaultAreaCode"];
        self.CloseTimeText=dic[@"CloseTimeText"];
        self.DeliveryDateText=dic[@"DeliveryDateText"];
        self.DefaultAreaText=dic[@"CommodityType"];
        self.Promotions=dic[@"Promotions"];
        self.WebPrice=dic[@"WebPrice"];
        self.MaxLimitCount=dic[@"MaxLimitCount"];
        self.OrderId=dic[@"OrderId"];
        self.PromotionsDetailsId=dic[@"PromotionsDetailsId"];
        self.VoteScore=dic[@"VoteScore"];
        self.VoteCount=dic[@"GiftRuVoteCountleType"];
        self.VotePositiveRate=dic[@"VotePositiveRate"];
        self.CardType=dic[@"CardType"];
        self.IsAutoHide=dic[@"IsAutoHide"];
        self.IsDealers=dic[@"IsDealers"];
        self.CategoryId=dic[@"CategoryId"];
        self.IsCanReturn=dic[@"IsCanReturn"];
        self.CanNoReasonToReturn=dic[@"CanNoReasonToReturn"];
        self.DeliveryTips=dic[@"DeliveryTips"];
        self.IsUseProductStock=dic[@"IsUseProductStock"];
        self.OrderDetailsId=dic[@"OrderDetailsId"];
        self.PointExchangeId=dic[@"PointExchangeId"];
        self.GetPoint=dic[@"GetPoint"];
        self.WarehouseId=dic[@"WarehouseId"];
        self.IsWordsCard=dic[@"IsWordsCard"];
        self.Words=dic[@"Words"];
        self.IsSecondary=dic[@"IsSecondary"];
        self.SubTitle=dic[@"SubTitle"];
                                
        
    }
    return self;
    
}

+(Product *) initWithDictionary:(NSDictionary *)dic
{
    Product *product=[[Product alloc]initWithDictionary:dic];
    return product;
}


@end
