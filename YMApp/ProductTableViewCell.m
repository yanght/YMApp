//
//  ProductTableViewCell.m
//  YMApp
//
//  Created by yannis on 15/12/23.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductTableViewCell.h"


@implementation ProductTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier productViewModel:(ProductViewModel *)productViewModel
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *productNameLabel=[[UILabel alloc]init];
        productNameLabel.numberOfLines=0;
        productNameLabel.text=productViewModel.product.CommodityName;
        productNameLabel.frame=productViewModel.productNameRect;
        [self.contentView addSubview:productNameLabel];
        
        
        UILabel *productPriceLabel=[[UILabel alloc]init];
        productPriceLabel.numberOfLines=1;
        [productPriceLabel setTextColor:RGB(246, 0, 49)];
        productPriceLabel.text=[NSString stringWithFormat:@"¥ %@",productViewModel.product.CommodityPrice];
        productPriceLabel.frame=productViewModel.productPriceRect;
        [self.contentView addSubview:productPriceLabel];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
