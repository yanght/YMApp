//
//  PlaceOfOriginCell.m
//  YMApp
//
//  Created by yannis on 15/12/26.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "PlaceOfOriginCell.h"
#define PaddingTop REAL_WIDTH1(20)

@interface PlaceOfOriginCell ()
{
    UILabel *_placeLabel;
    UILabel *_tipsLabel;
}
@end

@implementation PlaceOfOriginCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(REAL_WIDTH1(30), PaddingTop, REAL_WIDTH1(70), REAL_WIDTH1(28));
        label.text=@"产地";
        label.textColor=GRAYCOLOR;
        label.textAlignment=NSTextAlignmentLeft;
        label.font=[UIFont systemFontOfSize:14];
        //label.center=CGPointMake(label.center.x, self.center.y);
        [self.contentView addSubview:label];
        
        
        _placeLabel=[[UILabel alloc]init];
        _placeLabel.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_placeLabel];
        
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.numberOfLines=0;
        _tipsLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:_tipsLabel];
        
    }
    return self;
}

-(void)setPlaceOfOrigin:(NSString *)placeOfOrigin deliveryTips:(NSString *)tips
{
    _placeLabel.text=placeOfOrigin;
    _placeLabel.frame=CGRectMake(REAL_WIDTH1(30)+REAL_WIDTH1(70)+5, PaddingTop, screen_width-REAL_WIDTH1(85), REAL_WIDTH1(28));
    
    
    if ([tips isEqualToString:@""]) {
        _tipsLabel.frame=CGRectZero;
    }else
    {
     CGSize tipsSize=[tips  boundingRectWithSize:CGSizeMake(screen_width, MAXFLOAT) withFont:14];
     _tipsLabel.text=tips;
     _tipsLabel.frame=CGRectMake(REAL_WIDTH1(30), CGRectGetMaxY(_placeLabel.frame)+REAL_WIDTH1(20), tipsSize.width, tipsSize.height);
    }
    
    self.height=_placeLabel.frame.size.height+_tipsLabel.frame.size.height+PaddingTop*2+REAL_WIDTH1(20);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
