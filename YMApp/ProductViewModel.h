//
//  ProductViewModel.h
//  YMApp
//
//  Created by yannis on 15/12/22.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface ProductViewModel : NSObject

@property(nonatomic,assign)CGRect productNameRect;

@property(nonatomic,assign)CGRect productPriceRect;

@property(nonatomic,strong)NSArray *productSpecrect;

@property(nonatomic,strong)NSArray *productPromotionRect;

@property(nonatomic,assign)CGRect productPlaceRect;

@property(nonatomic,strong)Product *product;

-(id)initWithProduct:(Product *)product;

@property(nonatomic,assign)CGFloat height;

@end
