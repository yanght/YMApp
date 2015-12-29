//
//  ProductSpec.h
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSpec : NSObject

@property(nonatomic,strong)NSString *CommodityId;

@property(nonatomic,strong)NSString *CommodityCode;

@property(nonatomic,strong)NSString *CommodityName;

@property(nonatomic,strong)NSString *Spec;

-(ProductSpec *)initWithDictionary:(NSDictionary *)dic;

+(ProductSpec *)initWithDictionary:(NSDictionary *)dic;

@end
