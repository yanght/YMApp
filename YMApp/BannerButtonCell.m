//
//  BannerButtonCell.m
//  YMApp
//
//  Created by yannis on 15/11/3.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "BannerButtonCell.h"
#import "BannerButton.h"
#import "HomeBanner.h"

@implementation BannerButtonCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier banners:(NSArray *) banners
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
   
    UIView *backgrdView = [[UIView alloc] initWithFrame:self.frame];
    backgrdView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgrdView;
    
    if (self) {
        for (int i=0; i<banners.count; i++) {
            
            HomeBanner *banner=[banners objectAtIndex:i];
            
            BannerButton *button=[[BannerButton alloc]initWithFrame:CGRectMake((screen_width/4)*i, 5, screen_width/4, REAL_WIDTH(250)) title:banner.BannerName image:banner.PictureUrl];
           // button.backgroundColor=[UIColor redColor];
            [self addSubview:button];
        }
        
    }
    return self;
}

@end
