//
//  ProductTapProtocol.h
//  YMApp
//
//  Created by yannis on 15/12/29.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProductTapProtocol <NSObject>

-(void)didSelectProduct:(NSString *)commodityCode;

-(void)didSelectActivity:(NSString *)activityUrl;

@end
