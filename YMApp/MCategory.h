//
//  Category.h
//  YMApp
//
//  Created by yannis on 15/11/28.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCategory : NSObject

@property(nonatomic,strong) NSString *categoryName;

@property(nonatomic,strong) NSString *categoryImg;

@property(nonatomic,strong)NSString *sunCategorys;

@property(nonatomic,strong)NSString *categoryId;

@property(nonatomic,strong)NSString *categoryCode;

@property(nonatomic,strong)NSString *descrip;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)initWithDic:(NSDictionary *)dic;

@end
