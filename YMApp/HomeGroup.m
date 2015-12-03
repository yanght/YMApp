//
//  HomeGroup.m
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "HomeGroup.h"

@implementation HomeGroup

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if(self=[super init])
    {
        self.GroupId=dic[@"GroupId"];
        self.GroupTitle=dic[@"GroupTitle"];
        self.CountdownSeconds=dic[@"CountdownSeconds"];
        self.IsDynamic=dic[@"IsDynamic"];
    }
    return self;
}
+(instancetype)initWithDic:(NSDictionary *)dic
{
    HomeGroup *group=[[HomeGroup alloc]initWithDic:dic];
    return group;
}
@end
