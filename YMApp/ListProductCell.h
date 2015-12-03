//
//  ListProductCell.h
//  YMApp
//
//  Created by yannis on 15/11/22.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ListProductCell : UITableViewCell


@property(nonatomic,strong) Product *product;

@property(assign,nonatomic)CGFloat height;

@end
