//
//  HomeGroup.h
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeGroup : NSObject
@property (nonatomic,strong)NSString *GroupId;
@property (nonatomic,strong)NSString *GroupTitle;
@property (nonatomic,strong)NSString *CountdownSeconds;
@property(nonatomic,strong)NSMutableArray *HomeBanners;
@property (nonatomic,strong)NSString *IsDynamic;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)initWithDic:(NSDictionary *)dic;

@end
