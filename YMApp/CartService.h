//
//  CartService.h
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookieProductModel.h"

@interface CartService : NSObject

-(NSInteger)addProduct:(CookieProductModel *)product;

-(NSInteger)updateCartWith:(NSInteger)opertionType :(NSString *)productId;

-(NSInteger)getCartCount;

@end
