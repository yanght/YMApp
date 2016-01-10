//
//  CartSettleView.m
//  YMApp
//
//  Created by yannis on 16/1/9.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CartSettleView.h"
#import "YMRadioButton.h"

@interface CartSettleView ()
{
    YMRadioButton *_checkButton;
    UILabel *_promoPriceLabel;
    UILabel *_totleAmountLabel;
    UIButton *_settleButton;
    
}
@end

@implementation CartSettleView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _checkButton=[[YMRadioButton alloc]init];
        _checkButton.frame=CGRectMake(0, 0, REAL_WIDTH1(140), self.frame.size.height);
        [_checkButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [_checkButton setImageEdgeInsets:UIEdgeInsetsMake((_checkButton.frame.size.height-REAL_WIDTH1(40))/2, REAL_WIDTH1(25), (_checkButton.frame.size.height-REAL_WIDTH1(40))/2,REAL_WIDTH1(140-40-25))];
        [_checkButton setTitle:@"全选" forState:UIControlStateNormal];
        [_checkButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_checkButton setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        //    [_checkButton addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
        
        _promoPriceLabel=[[UILabel alloc]init];
        [_promoPriceLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_promoPriceLabel];
        
        _totleAmountLabel=[[UILabel alloc]init];
        [_totleAmountLabel setFont:[UIFont systemFontOfSize:14]];
        
        [self addSubview:_totleAmountLabel];
        
        _settleButton=[[UIButton alloc]init];
        [_settleButton setFrame:CGRectMake(screen_width-REAL_WIDTH1(200)-10, (self.frame.size.height-REAL_WIDTH1(80))/2, REAL_WIDTH1(200), REAL_WIDTH1(80))];
        
        [_settleButton setBackgroundColor:RGB(251, 61, 61)];
        [_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_settleButton.layer setCornerRadius:5];
        [self addSubview:_settleButton];
    }
    return self;
}

-(void)setPromotionPrice:(CGFloat)promotionPrice totleAmount:(CGFloat)totleAmount selectCount:(NSInteger)selectCount
{
    [_promoPriceLabel setText:[NSString stringWithFormat:@"优惠:%0.2f",promotionPrice]];
    CGSize promoSize=[_promoPriceLabel.text boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:12];
    [_promoPriceLabel setFrame:CGRectMake(CGRectGetMaxX(_checkButton.frame)+10, 5, promoSize.width, promoSize.height)];
    NSMutableAttributedString *attrsPromo=[_promoPriceLabel.text AttributedStringWithFont:nil withColor:[UIColor redColor] range:NSMakeRange(3,[_promoPriceLabel.text length]-3)];
    _promoPriceLabel.attributedText=attrsPromo;
    
    
    [_totleAmountLabel setText:[NSString stringWithFormat:@"商品总额:%0.2f",totleAmount]];
    CGSize totleSize=[_totleAmountLabel.text boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:14];
    NSMutableAttributedString *attrsTotal=[_totleAmountLabel.text AttributedStringWithFont:nil withColor:[UIColor redColor] range:NSMakeRange(5,[_totleAmountLabel.text length]-5)];
    _totleAmountLabel.attributedText=attrsTotal;
    [_totleAmountLabel setFrame:CGRectMake(CGRectGetMaxX(_checkButton.frame)+10, CGRectGetMaxY(_promoPriceLabel.frame)+5, totleSize.width, totleSize.height)];
    
   [_settleButton setTitle:[NSString stringWithFormat:@"去结算(%ld)",selectCount] forState:UIControlStateNormal];
}
@end
