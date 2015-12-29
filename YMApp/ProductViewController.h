//
//  ProductViewController.h
//  YMApp
//
//  Created by yannis on 15/11/25.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductViewModel.h"
#import "ProductTableViewCell.h"
#import "ProductSpecCell.h"

@interface ProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ProductSpecDelegate>

@property (nonatomic,strong)NSString *commodityCode;

@property (nonatomic,strong) Product *product;

@property(nonatomic,strong)ProductViewModel *productViewModel;

@property(nonatomic,strong)ProductTableViewCell *productTableViewCell;

@property (nonatomic,strong)UITableView *tableView;

@end
