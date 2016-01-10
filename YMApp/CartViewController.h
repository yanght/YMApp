//
//  CartViewController.h
//  YMApp
//
//  Created by yannis on 15/12/14.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"
#import "CartTableViewCell.h"
#import "CartSettleView.h"

@interface CartViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CartTableViewCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *coupanView;

@property(nonatomic,strong)CartSettleView *settleView;

@property(nonatomic,strong)CartModel *cartModel;

@end
