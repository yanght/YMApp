//
//  BannerButton.m
//  YMApp
//
//  Created by yannis on 15/11/3.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "BannerButton.h"
#import "Masonry/Masonry.h"
#import "UIImageView+WebCache.h"

@implementation BannerButton

-(id) initWithFrame:(CGRect)frame title:(NSString *) title image:(NSString *)image
{
    self=[super initWithFrame:frame];
    if(self)
    {
        UIImageView *imgview=[[UIImageView alloc]init];
        //imgview.image=[UIImage imageNamed:image];
        [imgview sd_setImageWithURL:[[NSURL alloc]initWithString:image]];
        //imgview.frame=CGRectMake(0, 0, 100, 100);
        
        [self addSubview:imgview];
        
        UILabel *label=[[UILabel alloc]init];
        //label.frame=CGRectMake(0,100 , 20, 20);
        label.text=title;
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextColor:[UIColor grayColor]];
        label.textAlignment=NSTextAlignmentCenter;
        //label.backgroundColor=[UIColor yellowColor];
        [self addSubview:label];
        
        [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(REAL_WIDTH(166), REAL_WIDTH(166)));
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgview.mas_bottom);
            make.width.equalTo(self);
            make.left.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

@end
