//
//  CartModel.h
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookieProductModel.h"

@interface CookieCartModel : JSONModel

@property(nonatomic,strong)NSString *WebsiteId;

@property(nonatomic,strong)NSString *Version;

@property(nonatomic,strong)NSString *CreateTime;

@property(nonatomic,strong)NSArray<CookieProductModel>* Commoditys;

@end
