//
//  CartModel.h
//  YMApp
//
//  Created by yannis on 16/1/8.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"



@protocol RspData @end

@interface RspData : JSONModel

@property(nonatomic,assign)CGFloat totalPrice;

@property(nonatomic,assign)CGFloat discountAmount;

@property(nonatomic,assign)NSInteger commodityGiftTotalCount;

@property(nonatomic,strong)NSArray<Product> *dataCommoditys;

@end


@interface CartModel : JSONModel

@property(nonatomic,strong)NSString *Method;

@property(nonatomic,assign)NSInteger RspCode;

@property(nonatomic,strong)NSString *RspMsg;

@property(nonatomic,strong)RspData *RspData;

@end


