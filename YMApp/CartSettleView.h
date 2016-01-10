//
//  CartSettleView.h
//  YMApp
//
//  Created by yannis on 16/1/9.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartSettleView : UIView

@property(nonatomic,assign)CGFloat promotionPrice;

@property(nonatomic,assign)CGFloat totleAmount;

@property(nonatomic,assign)NSInteger selectCount;


-(instancetype)initWithFrame:(CGRect)frame;

-(void)setPromotionPrice:(CGFloat)promotionPrice totleAmount:(CGFloat)totleAmount selectCount:(NSInteger)selectCount;

@end