//
//  ProductComment.m
//  YMApp
//
//  Created by yannis on 16/1/3.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "ProductComment.h"

@implementation ProductComment
-(ProductComment *)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.CommodityId=dic[@"CommodityId"];
        self.CommodityCode=dic[@"CommodityCode"];
        self.CommodityName=dic[@"CommodityName"];
        self.UserId=dic[@"UserId"];
        self.UserName=dic[@"UserName"];
        self.OrderId=dic[@"OrderId"];
        self.VoteResult=dic[@"VoteResult"];
        self.VoteDate=dic[@"VoteDate"];
        self.CommentContent=dic[@"CommentContent"];
        self.ReplyComment=dic[@"ReplyComment"];
        self.ProductEvaluate=dic[@"ProductEvaluate"];
        self.DeliveryEvaluate=dic[@"DeliveryEvaluate"];
        self.ServiceEvaluate=dic[@"ServiceEvaluate"];
        self.CommentState=dic[@"CommentState"];
        self.CreateTime=dic[@"CreateTime"];
        self.ModifyTime=dic[@"ModifyTime"];
        self.BuyTime=dic[@"BuyTime"];
        self.Recommend=dic[@"Recommend"];
        self.CommodityVoteId=dic[@"CommodityVoteId"];
        self.VotePictures=dic[@"VotePictures"];
        self.VotePicturesInfo=dic[@"VotePicturesInfo"];
        self.CommodityAmount=dic[@"CommodityAmount"];
        self.CommodityPrice=dic[@"CommodityPrice"];
        self.CommodityTotalPrice=dic[@"CommodityTotalPrice"];
        self.SmallPic=dic[@"SmallPic"];
    }
    return self;
}

+(ProductComment *)initWithDictionart:(NSDictionary *)dic
{
    ProductComment *comment=[[ProductComment alloc]initWithDictionary:dic];
    return comment;
}

@end
