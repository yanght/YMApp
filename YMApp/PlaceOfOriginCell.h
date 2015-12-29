//
//  PlaceOfOriginCell.h
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductCell.h"

@interface PlaceOfOriginCell : BaseProductCell

@property(nonatomic,strong)NSString *DeliveryTips;

@property(nonatomic,strong)NSString *PlaceOfOrigin;

-(void)setPlaceOfOrigin:(NSString *)placeOfOrigin deliveryTips:(NSString *)tips;

@end
