//
//  ProductNameCell.m
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductNameCell.h"
#define PaddingLeft REAL_WIDTH1(35)

@interface ProductNameCell ()
{
    UILabel *_productNameLabel;
    UILabel *_productPriceLabel;
    UILabel *_oldProductPriceLabel;
}

@end

@implementation ProductNameCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _productNameLabel=[[UILabel alloc]init];
        _productNameLabel.numberOfLines=0;
//        _productNameLabel.backgroundColor=[UIColor redColor];
        _productNameLabel.font=[UIFont systemFontOfSize:18];
        [self.contentView addSubview:_productNameLabel];
        
        
        _productPriceLabel=[[UILabel alloc]init];
        _productPriceLabel.numberOfLines=0;
        _productPriceLabel.textColor=RGB(253, 54, 75);
//        _productPriceLabel.backgroundColor=[UIColor redColor];
        _productPriceLabel.font=[UIFont systemFontOfSize:18];
        [self.contentView addSubview:_productPriceLabel];
        
        
        _oldProductPriceLabel=[[UILabel alloc]init];
//        _oldProductPriceLabel.backgroundColor=[UIColor redColor];
        _oldProductPriceLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:_oldProductPriceLabel];
        
    }
    return self;
}

-(void)setProductName:(NSString *)productName productPrice:(NSString *)productprice oldProductPrice:(NSString *)oldProductPrice
{
    CGSize size=[productName boundingRectWithSize:CGSizeMake(screen_width-20-PaddingLeft, MAXFLOAT) withFont:18];
    _productNameLabel.frame=CGRectMake(PaddingLeft, 5, size.width,size.height);
    _productNameLabel.text=productName;
    
    CGSize priceSize=[[NSString stringWithFormat:@"¥%.2f",[productprice floatValue]] boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:18];
    _productPriceLabel.frame=CGRectMake(PaddingLeft, CGRectGetMaxY(_productNameLabel.frame)+REAL_WIDTH1(30), priceSize.width+5, priceSize.height);
    _productPriceLabel.text=[NSString stringWithFormat:@"¥%.2f",[productprice floatValue]];
    _productPriceLabel.font=[UIFont boldSystemFontOfSize:18];
    NSMutableAttributedString *attrs=[_productPriceLabel.text AttributedStringWithFont:[UIFont systemFontOfSize:14] withColor:nil range:NSMakeRange(0,1)];
    _productPriceLabel.attributedText=attrs;
    
    
    self.height=CGRectGetMaxY(_productPriceLabel.frame)+5;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
