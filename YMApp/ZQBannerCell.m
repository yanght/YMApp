//
//  ZQBannerCell.m
//  YMApp
//
//  Created by yannis on 15/11/3.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "ZQBannerCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "HomeGroup.h"
#import "HomeBanner.h"


@interface ZQBannerCell ()
{
    UILabel *_titleLabel;
}

@end

@implementation ZQBannerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier group:(HomeGroup *) group
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
    _titleLabel=[[UILabel alloc]init];
    [_titleLabel setText:group.GroupTitle];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [_titleLabel setFrame:CGRectMake(REAL_WIDTH1(20), 0, screen_width, REAL_WIDTH1(60))];
    [self.contentView addSubview:_titleLabel];
    
    for (int i=0; i<group.HomeBanners.count; i++) {
        HomeBanner *banner=[group.HomeBanners objectAtIndex:i];
        
        UIImageView *imgView=[[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[[NSURL alloc]initWithString:banner.PictureUrl]];
        CGRect frame;
        if(i==0)
        {
            frame=CGRectMake(REAL_WIDTH1(10), REAL_WIDTH1(60), REAL_WIDTH1(251), REAL_WIDTH1(399));
        }
        if(i==1)
        {
            frame=CGRectMake(REAL_WIDTH1(261), REAL_WIDTH1(60), REAL_WIDTH1(370), REAL_WIDTH1(200));
        }
        if(i==2)
        {
            frame=CGRectMake(REAL_WIDTH1(261), REAL_WIDTH1(200)+REAL_WIDTH1(60), REAL_WIDTH1(370), REAL_WIDTH1(200));
        }
        imgView.layer.borderWidth=0.5;
        imgView.layer.borderColor=RGB(222, 222, 222).CGColor;
        imgView.frame=frame;
        [imgView setTag:300+i];
        [self.contentView addSubview:imgView];
        
        YmGestureRecognizer*tap=[[YmGestureRecognizer alloc]initWithTarget:self action:@selector(didTapView:)];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:banner.LinkCode forKey:@"LinkCode"];
        [dic setObject:banner.LinkType forKey:@"LinkType"];
        [dic setObject:banner.LinkUrl forKey:@"LinkUrl"];
        tap.parm=dic;
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:tap];
    }
    }
    return self;
}
-(void)setGroup:(HomeGroup *)group
{
    _titleLabel.text=group.GroupTitle;
    
    for (int i=0; i<group.HomeBanners.count; i++) {
        
        HomeBanner *banner=[group.HomeBanners objectAtIndex:i];
        
        UIImageView *imgView=[[UIImageView alloc]viewWithTag:300+i];
        
        [imgView sd_setImageWithURL:[[NSURL alloc]initWithString:banner.PictureUrl]];
    
    }
}

-(void)didTapView:(YmGestureRecognizer *)sender
{
    NSMutableDictionary *dic=sender.parm;
    
    NSString *linkCode=[dic objectForKey:@"LinkCode"];
    NSInteger linkType=[[dic objectForKey:@"LinkType"] integerValue];
    NSString *linkUrl=[dic objectForKey:@"LinkUrl"];
    
    if (linkType==1) {
        [self.delegate didSelectProduct:linkCode];
    }else if (linkType==3)
    {
        [self.delegate didSelectActivity:linkUrl];
    }
}
@end
