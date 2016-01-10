//
//  ProductComment.h
//  YMApp
//
//  Created by yannis on 16/1/3.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductComment : NSObject

@property(nonatomic,strong)NSString *CommodityId;

@property(nonatomic,strong)NSString *CommodityCode;

@property(nonatomic,strong)NSString *CommodityName;

@property(nonatomic,strong)NSString *UserId;

@property(nonatomic,strong)NSString *UserName;

@property(nonatomic,strong)NSString *OrderId;

@property(nonatomic,strong)NSString *VoteResult;

@property(nonatomic,strong)NSString *VoteDate;

@property(nonatomic,strong)NSString *CommentContent;

@property(nonatomic,strong)NSString *ReplyComment;

@property(nonatomic,strong)NSString *ProductEvaluate;

@property(nonatomic,strong)NSString *DeliveryEvaluate;

@property(nonatomic,strong)NSString *ServiceEvaluate;

@property(nonatomic,strong)NSString *CommentState;

@property(nonatomic,strong)NSString *CreateTime;

@property(nonatomic,strong)NSString *ModifyTime;

@property(nonatomic,strong)NSString *BuyTime;

@property(nonatomic,strong)NSString *Recommend;

@property(nonatomic,strong)NSString *CommodityVoteId;

@property(nonatomic,strong)NSString *VotePictures;

@property(nonatomic,strong)NSString *VotePicturesInfo;

@property(nonatomic,strong)NSString *CommodityAmount;

@property(nonatomic,strong)NSString *CommodityPrice;

@property(nonatomic,strong)NSString *CommodityTotalPrice;

@property(nonatomic,strong)NSString *SmallPic;


-(ProductComment *)initWithDictionary:(NSDictionary *)dic;
+(ProductComment *)initWithDictionart:(NSDictionary *)dic;

@end
