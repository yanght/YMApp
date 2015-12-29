//
//  Promotion.h
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Promotion : NSObject

@property(nonatomic,strong)NSString *PromotionsId;

@property(nonatomic,strong)NSString *PromotionsType;

@property(nonatomic,strong)NSString *PromotionsTitle;

@property(nonatomic,strong)NSString *PromotionsTag;

@property(nonatomic,strong)NSString *SaleFlag;

@property(nonatomic,strong)NSString *SaleText;

@property(nonatomic,strong)NSString *LinkType;

@property(nonatomic,strong)NSString *LinkCode;

@property(nonatomic,strong)NSString *LinkUrl;

-(Promotion *)initWithDictionary:(NSDictionary *)dic;
+(Promotion *)initWithDictionary:(NSDictionary *)dic;

@end
