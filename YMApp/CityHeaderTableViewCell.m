//
//  CityHeaderTableViewCell.m
//  YMApp
//
//  Created by yannis on 15/12/16.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "CityHeaderTableViewCell.h"
#import "City.h"

@implementation CityHeaderTableViewCell

-(void)setCityList:(NSArray *)cityList
{
   __block CGRect lastFrame=CGRectMake(0, 0, 0, 0);
    
    [cityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         City *city=obj;
        UIButton *button=[[UIButton alloc]init];
        [button setTitle:city.Name forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:RGB(108, 108, 108) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button.layer setBorderWidth:0.5];
        [button.layer setBorderColor:GRAYCOLOR.CGColor];
        [button.layer setCornerRadius:5];
        [button setFrame:CGRectMake(REAL_WIDTH1(141)*idx, 0,REAL_WIDTH1(141),REAL_WIDTH1(57))];
        [self.contentView addSubview:button];
        if (idx==0) {
            [button setFrame:CGRectMake(REAL_WIDTH1(49), 0, REAL_WIDTH1(141), REAL_WIDTH1(57))];
        }else
        {
            if (lastFrame.origin.x<screen_width) {
           [button setFrame:CGRectMake(CGRectGetMaxX(lastFrame)+REAL_WIDTH1(49), CGRectGetMinY(lastFrame), REAL_WIDTH1(141), REAL_WIDTH1(57))];
            }else
            {
                [button setFrame:CGRectMake(REAL_WIDTH1(49), CGRectGetMinY(lastFrame)+REAL_WIDTH1(57+16), REAL_WIDTH1(141), REAL_WIDTH1(57))];
            }
        }
        lastFrame=button.frame;
    }];
    
    self.cellheight=CGRectGetMaxY(lastFrame);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
