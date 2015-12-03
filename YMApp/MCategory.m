//
//  Category.m
//  YMApp
//
//  Created by yannis on 15/11/28.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "MCategory.h"

@implementation MCategory
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if(self=[super init])
    {
        self.categoryId=[dic objectForKey:@"CategoryId"];
        self.categoryName=[dic objectForKey:@"CategoryName"];
        self.categoryCode=[dic objectForKey:@"CategoryCode"];
        self.descrip=[dic objectForKey:@"Description"];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"];
        NSDictionary *dic=[[NSDictionary alloc]initWithContentsOfFile:path];
        
        self.categoryImg=[dic objectForKey:self.categoryName];
        
    }
    return self;
}

+(instancetype) initWithDic:(NSDictionary *)dic
{
    MCategory *category=[[MCategory alloc]initWithDic:dic];
    return category;
}
@end
