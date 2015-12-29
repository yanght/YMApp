//
//  ProductPromotionCell.m
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductPromotionCell.h"

@implementation ProductPromotionCell

-(void)setPromotion:(Promotion *)promotion
{
    
    UILabel *proLabel=[[UILabel alloc]init];
    proLabel.backgroundColor=RGB(253, 54, 75);
    proLabel.textColor=[UIColor whiteColor];
    proLabel.font=[UIFont systemFontOfSize:12];
    proLabel.textAlignment=NSTextAlignmentCenter;
    proLabel.text=@"限购";

    [self.contentView addSubview:proLabel];
    
    CGSize labelSize=[proLabel.text boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:14];
    proLabel.frame=CGRectMake(REAL_WIDTH1(30),8, labelSize.width, labelSize.height);
    
    
    CGSize tipsSize=[promotion.SaleText boundingRectWithSize:CGSizeMake(screen_width-W(proLabel)-REAL_WIDTH1(30)-30, MAXFLOAT) withFont:14];
    UILabel *tipsLabel=[[UILabel alloc]init];
    tipsLabel.text=promotion.SaleText;
    tipsLabel.numberOfLines=0;
    tipsLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:tipsLabel];
    tipsLabel.frame=CGRectMake(CGRectGetMaxX(proLabel.frame)+5,5, tipsSize.width, tipsSize.height);
    proLabel.center=CGPointMake(proLabel.center.x, (tipsSize.height+10)/2);
    tipsLabel.center=CGPointMake(tipsLabel.center.x, (tipsSize.height+10)/2);
    self.height=tipsSize.height+10;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
