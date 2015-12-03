//
//  HomeBanner.h
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBanner : NSObject
@property (nonatomic,strong)NSString *BannerId;
@property(nonatomic,strong)NSString *BannerName;
@property(nonatomic,strong)NSString *LinkChannel;
@property(nonatomic,strong)NSString *LinkType;
@property(nonatomic,strong)NSString *LinkCode;
@property(nonatomic,strong)NSString *LinkUrl;
@property(nonatomic,strong)NSString *PictureUrl;
@property (nonatomic,strong)NSString *AdPost;
@property(nonatomic,strong)NSString *Tag;
@property(nonatomic,strong)NSString *Badge;


-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)initWithDic:(NSDictionary *)dic;

@end
