//
//  CookieProductModel.h
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CookieProductModel @end

@interface CookieProductModel : JSONModel

@property(nonatomic,strong)NSString *Id;

@property(nonatomic,strong)NSString *Code;

@property(nonatomic,assign)NSInteger Amount;

@property(nonatomic,strong)NSString<Optional> *GId;

@end
