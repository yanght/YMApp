//
//  ProductSpecCell.h
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductCell.h"

@protocol ProductSpecDelegate <NSObject>

-(void)didSelectProduct:(NSString *)commodityCode;

@end

@interface ProductSpecCell :BaseProductCell

@property(nonatomic,strong)NSArray *specs ;

@property(nonatomic,assign)id<ProductSpecDelegate> delegate;

-(void)setSpecs:(NSArray *)specs commodityCode:(NSString *)commodityCode;

@end
