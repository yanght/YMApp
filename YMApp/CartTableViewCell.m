//
//  CartTableViewCell.m
//  YMApp
//
//  Created by yannis on 16/1/7.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CartTableViewCell.h"
#import "YMRadioButton.h"
#import "CartService.h"

#define PaddingTop REAL_WIDTH1(25)


@interface CartTableViewCell ()
{
    YMRadioButton *_radioButton;
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UIButton *_addButton;
    UIButton *_minusButton;
    UILabel *_numberLabel;
}

@end

@implementation CartTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        _radioButton=[[YMRadioButton alloc]init];
        [_radioButton setFrame:CGRectMake(0, 0, REAL_WIDTH1(90), REAL_WIDTH1(190))];
        _radioButton.imageEdgeInsets=UIEdgeInsetsMake(REAL_WIDTH1(75), REAL_WIDTH1(25), REAL_WIDTH1(75), REAL_WIDTH1(25));
        [_radioButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_radioButton];
        
        _imageView=[[UIImageView alloc]init];
        _imageView.frame=CGRectMake(CGRectGetMaxX(_radioButton.frame), PaddingTop, REAL_WIDTH1(140), REAL_WIDTH1(140));
       
        _imageView.layer.cornerRadius=5;
        [self.contentView addSubview:_imageView];
        
        
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.numberOfLines=0;
        [self.contentView addSubview:_nameLabel];
        
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.font=[UIFont systemFontOfSize:13];
       // _priceLabel.textColor=GRAYCOLOR;
        [self.contentView addSubview:_priceLabel];
        
        _minusButton=[[UIButton alloc]init];
        _minusButton.tag=1101;
        [_minusButton setImage:[UIImage imageNamed:@"iconfont-minus"] forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_minusButton];
        
        _numberLabel=[[UILabel alloc]init];
        _numberLabel.font=[UIFont systemFontOfSize:13];
        _numberLabel.textAlignment=NSTextAlignmentCenter;
        _numberLabel.numberOfLines=1;
        [self.contentView addSubview:_numberLabel];
        
        _addButton =[[UIButton alloc]init];
        _addButton.tag=1102;
        [_addButton setImage:[UIImage imageNamed:@"iconfont-add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addButton];
    }
    return self;
}

-(void)setProduct:(Product *)product
{
    _product=product;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:product.SmallPic] placeholderImage:[UIImage imageNamed:@""]];
    
    CGSize nameSize=[product.CommodityName boundingRectWithSize:CGSizeMake(screen_width-CGRectGetMaxX(_imageView.frame)-10, MAXFLOAT) withFont:14];
    _nameLabel.frame=CGRectMake(CGRectGetMaxX(_imageView.frame)+10, PaddingTop, nameSize.width, nameSize.height);
    _nameLabel.text=product.CommodityName;

    CGSize priceSize=[[NSString stringWithFormat:@"¥ %.2f",[product.CommodityPrice floatValue]] boundingRectWithSize:CGSizeMake(200, MAXFLOAT) withFont:14];
    
    _priceLabel.frame=CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMaxY(_imageView.frame)-priceSize.height, priceSize.width, priceSize.height);
    _priceLabel.text=[NSString stringWithFormat:@"¥ %.2f",[product.CommodityPrice floatValue]];
    
    
    _minusButton.frame=CGRectMake(screen_width-REAL_WIDTH1(180),REAL_WIDTH1(190-68), REAL_WIDTH1(52), REAL_WIDTH1(52));
    
    _numberLabel.frame=CGRectMake(CGRectGetMaxX(_minusButton.frame),CGRectGetMinY(_minusButton.frame), REAL_WIDTH1(45), REAL_WIDTH1(52));
    
    _addButton.frame=CGRectMake(CGRectGetMaxX(_numberLabel.frame), CGRectGetMinY(_minusButton.frame), REAL_WIDTH1(52), REAL_WIDTH1(52));
    _numberLabel.text=[NSString stringWithFormat:@"%@",product.CommodityAmount];
}

-(void)buttonClick:(id)sender
{
    CartService *svc=[[CartService alloc]init];
    NSInteger count=0;
    
    if (![_numberLabel.text isEqualToString:@""]) {
        count=[_numberLabel.text integerValue];
    }
    self.buyNumber=count;
    
    UIButton *button=sender;
    if (button.tag==1101) {
        if (self.buyNumber>0) {
             self.buyNumber-=1;
            [svc updateCartWith:0 :self.product.CommodityId];
        }
    }else
    {
        self.buyNumber+=1;
        [svc updateCartWith:1 :self.product.CommodityId];
    }
    
    [self.delegate updateShopCart];
    
    /**
     *  每次加减购物车时刷新这个购物车table时会重新绑定数量值，不需要再赋值
     */
   // _numberLabel.text=[NSString stringWithFormat:@"%ld",self.buyNumber];
}

-(void)checkButtonClick:(id)sender
{
    self.isSelected=!self.isSelected;
    [self.delegate CheckButtonClick];
}

@end
