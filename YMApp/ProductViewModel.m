//
//  ProductViewModel.m
//  YMApp
//
//  Created by yannis on 15/12/22.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductViewModel.h"
#define PaddingLeft REAL_WIDTH1(35)

@implementation ProductViewModel

-(id)initWithProduct:(Product *)product
{
    if ([super init]) {
        _product=product;
        
        CGSize size=[product.CommodityName boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:18];
        self.productNameRect=CGRectMake(PaddingLeft, 0, size.width,size.height);
        
        CGSize priceSize=[[NSString stringWithFormat:@"¥ %@",product.CommodityPrice] boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:18];
        self.productPriceRect=CGRectMake(PaddingLeft, CGRectGetMaxY(self.productNameRect)+REAL_WIDTH1(30), priceSize.width, priceSize.height);
        
        
        
    }
    self.height=self.productNameRect.size.height+self.productPriceRect.size.height;
    return self;
}

@end
