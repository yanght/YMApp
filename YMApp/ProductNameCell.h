//
//  ProductNameCell.h
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductCell.h"

@interface ProductNameCell : BaseProductCell

@property(nonatomic,strong)NSString *productName;

@property(nonatomic,strong)NSString *productPrice;

@property(nonatomic,strong)NSString *oldProductPrice;

-(void)setProductName:(NSString *)productName productPrice:(NSString *)productprice oldProductPrice:(NSString *)oldProductPrice;

@end
