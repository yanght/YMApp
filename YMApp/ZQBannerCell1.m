//
//  ZQBannerCell1.m
//  YMApp
//
//  Created by yannis on 15/11/4.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "ZQBannerCell1.h"

@implementation ZQBannerCell1

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    

    if(self)
    {
//        UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (720/1242)*W(self), (720/1242)*W(self)*(388/720))];
        
        UIImageView *imgView1=[[UIImageView alloc]init];
        imgView1.image=[UIImage imageNamed:@"01.jpg"];
        [self addSubview:imgView1];
        
        UIImageView *imgView2=[[UIImageView alloc]init];
        
        imgView2.image=[UIImage imageNamed:@"01.jpg"];
        [self addSubview:imgView2];
        
        UIImageView *imgview3=[[UIImageView alloc]init];
        imgview3.image=[UIImage imageNamed:@"01.jpg"];
        [self addSubview:imgview3];
        
        [imgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset((17.0/1242)*screen_width);
            make.top.equalTo(self);
            make.width.mas_equalTo((720.0/1242)*screen_width);
            make.height.mas_equalTo((388.0/1242)*screen_width);
            make.right.equalTo(imgview3.mas_left).offset(-5);
        }];
        
        [imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView1.mas_bottom);
            make.height.equalTo(imgView1.mas_height);
            make.width.equalTo(imgView1);
            make.left.equalTo(self).offset((17.0/1242)*screen_width);
        }];
        
        [imgview3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-(17.0/1242)*screen_width);
            make.top.equalTo(self);
            make.bottom.equalTo(imgView2.mas_bottom);
            make.left.equalTo(imgView1.mas_right).offset(5);
        }];
    }
    return self;
}


@end
