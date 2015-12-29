//
//  ProductPromotionCell.h
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promotion.h"
#import "BaseProductCell.h"

@interface ProductPromotionCell : BaseProductCell
@property(nonatomic,strong) Promotion *promotion;
@end
