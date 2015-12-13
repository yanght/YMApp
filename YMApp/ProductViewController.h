//
//  ProductViewController.h
//  YMApp
//
//  Created by yannis on 15/11/25.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSString *commodityCode;

@property (nonatomic,strong) Product *product;

@property (nonatomic,strong)UITableView *tableView;

@end
