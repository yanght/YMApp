//
//  ProductSpecCell.m
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductSpecCell.h"
#import "ProductSpec.h"

@interface ProductSpecCell ()
{
   // NSString *_commodityCode;
}

@end

@implementation ProductSpecCell

-(void)setSpecs:(NSArray *)specs commodityCode:(NSString *)commodityCode
{
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(REAL_WIDTH1(30), 0, REAL_WIDTH1(70), REAL_WIDTH1(28));
    label.text=@"规格";
    label.textColor=GRAYCOLOR;
    label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:14];
    label.center=CGPointMake(label.center.x, self.center.y);
    [self.contentView addSubview:label];
    
    __block UIButton *lastButton=nil;
    [specs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ProductSpec *spec=obj;
        CGSize specsize=[spec.Spec boundingRectWithSize:CGSizeMake(screen_width, REAL_WIDTH1(46)) withFont:14];
        UIButton *specbutton=[[UIButton alloc]init];
        [specbutton setTitle:spec.Spec forState:UIControlStateNormal];
        [specbutton setTitleColor:commodityCode==spec.CommodityCode?MAINCOLOR:GRAYCOLOR forState:UIControlStateNormal];
        [specbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, REAL_WIDTH1(18), 0, REAL_WIDTH1(18))];
        [specbutton.layer setBorderWidth:1];
        [specbutton.layer setBorderColor:commodityCode==spec.CommodityCode?MAINCOLOR.CGColor:GRAYCOLOR.CGColor];
        [specbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [specbutton.layer setCornerRadius:5];
        
        [specbutton addTarget:self action:@selector(specButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:specbutton];
        if (idx==0) {
             [specbutton setFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, 0, specsize.width+REAL_WIDTH1(36), REAL_WIDTH1(46))];
        }else
        {
            [specbutton setFrame:CGRectMake(CGRectGetMaxX(lastButton.frame)+REAL_WIDTH1(20), 0, specsize.width+REAL_WIDTH1(36), REAL_WIDTH1(46))];
            if (specbutton.frame.origin.x>screen_width) {
                 [specbutton setFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, CGRectGetMaxY(lastButton.frame)+5, specsize.width+REAL_WIDTH1(36), REAL_WIDTH1(46))];
            }
        }
        specbutton.tag=[spec.CommodityCode integerValue];
        specbutton.center=CGPointMake(specbutton.center.x, self.center.y);
        lastButton=specbutton;
    }];
    self.height=H(label)+28;
}
-(void)specButtonClick:(id)sender
{
    UIButton *button=sender;
    [self.delegate didSelectProduct:[NSString stringWithFormat:@"%ld",(long)button.tag]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
