//
//  Product.h
//  YMApp
//
//  Created by yannis on 15/11/22.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Product @end

@interface Product : JSONModel

@property (nonatomic,copy) NSString *CommodityId;
@property (nonatomic,copy) NSString *CommodityCode;
@property (nonatomic,copy) NSString *CommodityName;
@property (nonatomic,copy) NSString *CommodityAmount;
@property (nonatomic,copy) NSString *CommodityType;
@property (nonatomic,copy) NSString *OriginalPrice;
@property (nonatomic,copy) NSString *CommodityPrice;
@property (nonatomic,copy) NSString *CommodityTotalPrice;
@property (nonatomic,copy) NSString *State;
@property (nonatomic,copy) NSString *DeliveryArea;
@property (nonatomic,copy) NSString *Spec;
@property (nonatomic,copy) NSString *SpecId;
@property (nonatomic,copy) NSString *BrandName;
@property (nonatomic,copy) NSString *PlaceOfOrigin;
@property (nonatomic,copy) NSArray *Pictures;
@property (nonatomic,copy) NSString *SmallPic;
@property (nonatomic,copy) NSArray *Speces;
@property (nonatomic,copy) NSString *Description;
@property (nonatomic,copy) NSString *IsFreedom;
@property (nonatomic,copy) NSString *IsSpecial;
@property (nonatomic,copy) NSString *IsGift;
@property (nonatomic,copy) NSString *CouponCode;
@property (nonatomic,copy) NSString *GiftRuleId;
@property (nonatomic,copy) NSString *GiftRuleType;
@property (nonatomic,copy) NSString *OrderDetailsType;
@property (nonatomic,copy) NSString *UsePoint;
@property (nonatomic,copy) NSString *PriceType;
@property (nonatomic,copy) NSString *ShowOriginalPrice;
@property (nonatomic,copy) NSString *CommodityDeliveryDate;
@property (nonatomic,copy) NSString *CommodityDeliveryTime;
@property (nonatomic,copy) NSString *DefaultAreaCode;
@property (nonatomic,copy) NSString *CloseTimeText;
@property (nonatomic,copy) NSString *DeliveryDateText;
@property (nonatomic,copy) NSString *DefaultAreaText;
@property (nonatomic,copy) NSArray *Promotions;
@property (nonatomic,copy) NSString *WebPrice;
@property (nonatomic,copy) NSString *AppPrice;
@property (nonatomic,copy) NSString *MaxLimitCount;
@property (nonatomic,copy) NSString *OrderId;
@property (nonatomic,copy) NSString *PromotionsDetailsId;
@property (nonatomic,copy) NSString *VoteScore;
@property (nonatomic,copy) NSString *VoteCount;
@property (nonatomic,copy) NSString *VotePositiveRate;
@property (nonatomic,copy) NSString *CardType;
@property (nonatomic,copy) NSString *IsAutoHide;
@property (nonatomic,copy) NSString *IsDealers;
@property (nonatomic,copy) NSString *CategoryId;
@property (nonatomic,copy) NSString *IsCanReturn;
@property (nonatomic,copy) NSString *CanNoReasonToReturn;
@property (nonatomic,copy) NSString *DeliveryTips;
@property (nonatomic,copy) NSString *IsUseProductStock;
@property (nonatomic,copy) NSString *OrderDetailsId;
@property (nonatomic,copy) NSString *PointExchangeId;
@property (nonatomic,copy) NSString *GetPoint;
@property (nonatomic,copy) NSString *WarehouseId;
@property (nonatomic,copy) NSString *IsWordsCard;
@property (nonatomic,copy) NSString *Words;
@property (nonatomic,copy) NSString *IsSecondary;
@property (nonatomic,copy) NSString *SubTitle;



-(Product *)initWithDictionary:(NSDictionary *)dic;

+(Product *)initWithDictionary:(NSDictionary *)dic;

@end
