//
//  HomeBanner.m
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "HomeBanner.h"

@implementation HomeBanner

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if(self=[super init])
    {
        self.BannerId=dic[@"BannerId"];
        self.BannerName=dic[@"BannerName"];
        self.LinkChannel=dic[@"LinkChannel"];
        self.LinkType=dic[@"LinkType"];
        self.LinkCode=dic[@"LinkCode"];
        self.LinkUrl=dic[@"LinkUrl"];
        self.PictureUrl=dic[@"PictureUrl"];
        self.AdPost=dic[@"AdPost"];
        self.Tag=dic[@"Tag"];
        self.Badge=dic[@"Badge"];
    }
    return self;
}

+(instancetype)initWithDic:(NSDictionary *)dic
{
    HomeBanner *banner=[[HomeBanner alloc]initWithDic:dic];
    return banner;
}

@end
