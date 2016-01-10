//
//  CartService.m
//  YMApp
//
//  Created by yannis on 16/1/6.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CartService.h"
#import "CookieCartModel.h"

@implementation CartService

/**
 *  添加购物车
 *
 *  @param product 购物车商品模型
 *
 *  @return 购物车商品数量
 */
-(NSInteger)addProduct:(CookieProductModel *)product
{
    CookieCartModel *cartmodel=[self getCartModel];
    
    NSArray<CookieProductModel> *products=cartmodel.Commoditys;
    
    NSMutableArray *cartpeoducts=[[NSMutableArray alloc]init];
    cartpeoducts=[products mutableCopy];
    
    __block Boolean hasProduct=FALSE;
    [cartpeoducts enumerateObjectsUsingBlock:^(CookieProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.Id isEqualToString:product.Id]) {
            obj.Amount+=product.Amount;
            hasProduct=true;
        }
    }];
    if (!hasProduct) {
        [cartpeoducts addObject:product];
    }
    
    products=[cartpeoducts copy];
    cartmodel.CreateTime=[NSString  stringWithFormat:@"%@",[NSDate date]];
    cartmodel.Commoditys=products;
    NSString  *str=[cartmodel toJSONString];
    
    [self saveCartModel:str];
    
    __block NSInteger cartCount=0;
    [cartmodel.Commoditys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CookieProductModel *product=obj;
        cartCount+=product.Amount;
    }];
    
    //添加购物车后通知tabbar刷新购物车商品数量
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ChangeTabbarBadgeValueNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",cartCount],@"cartCount", nil]];
    
    return cartCount;
}

/**
 *  刷新购物车商品
 *
 *  @param opertionType 刷新类型 0:减少一个商品数量 1:增加一个商品数量 2:删除一个商品
 *  @param productId    商品id
 *
 *  @return 购物车商品数量
 */
-(NSInteger)updateCartWith:(NSInteger)opertionType :(NSString *)productId
{
   
    CookieCartModel *cartmodel=[self getCartModel];
    
    NSArray<CookieProductModel> *products=cartmodel.Commoditys;
    
    NSMutableArray *cartpeoducts=[[NSMutableArray alloc]init];
    cartpeoducts=[products mutableCopy];
    
    __block NSUInteger removeIndex=NSUIntegerMax;
    [cartpeoducts enumerateObjectsUsingBlock:^(CookieProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.Id isEqualToString:productId]) {
            if (opertionType==1) {
                obj.Amount+=1;
            }else if (opertionType==0)
            {
                obj.Amount-=1;
            }else if(opertionType==2)
            {
                removeIndex=idx;
            }
            if (obj.Amount==0) {
                removeIndex=idx;
            }
        }
    }];
    if (removeIndex!=NSUIntegerMax) {
        [cartpeoducts removeObjectAtIndex:removeIndex];
    }
    
    products=[cartpeoducts copy];
    cartmodel.CreateTime=[NSString  stringWithFormat:@"%@",[NSDate date]];
    cartmodel.Commoditys=products;
    NSString  *str=[cartmodel toJSONString];
    
    [self saveCartModel:str];
    
    __block NSInteger cartCount=0;
    [cartmodel.Commoditys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CookieProductModel *product=obj;
        cartCount+=product.Amount;
    }];
    
    //添加购物车后通知tabbar刷新购物车商品数量
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ChangeTabbarBadgeValueNotification object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",cartCount],@"cartCount", nil]];
    NSLog(@"%@",[cartmodel toJSONString]);
    return cartCount;
}

/**
 *  获取购物车商品数量
 *
 *  @return 购物车商品数量
 */
-(NSInteger)getCartCount
{
    /**
     先从Userdefault中查询购物车数据，查不出来就从cookie中获取
     */
    CookieCartModel *cartmodel=[self getCartModel];
    
    __block NSInteger cartCount=0;
    [cartmodel.Commoditys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CookieProductModel *product=obj;
        cartCount+=product.Amount;
    }];
    
    return cartCount;

}


-(CookieCartModel *)getCartModel
{
    CookieHelper *helper=[[CookieHelper alloc]init];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    /**
     先从Userdefault中查询购物车数据，查不出来就从cookie中获取
     */
    CookieCartModel *cartmodel=[[CookieCartModel alloc]initWithString:[userDef objectForKey:USERDEFAULT_CART_KEY] error:NULL];
    if ([cartmodel.Commoditys count]==0) {
        cartmodel=[[CookieCartModel alloc]initWithString:[helper getCookieWithUrl:GET_COOKIE_URL cookieName:CART_COOKIE_NAME] error:NULL];
    }
    return cartmodel;
}

-(void)saveCartModel:(NSString *)str
{
    CookieHelper *helper=[[CookieHelper alloc]init];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];

    /**
     *  将购物车数据以cookie发送至服务器
     */
    NSMutableDictionary *cookieValues=[helper bulidCookieName:CART_COOKIE_NAME value:str domain:COOKIE_DOMAIN];
    [helper addCookieWithUrl:GET_COOKIE_URL value:cookieValues];
    
    /**
     *  将购物车数据写入UserDefalut中
     */
    if (userDef) {
        [userDef setObject:str forKey:USERDEFAULT_CART_KEY];
    }
}

@end
