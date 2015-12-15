//
//  CityViewController.h
//  YMApp
//
//  Created by yannis on 15/12/14.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UIView *headerView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableDictionary *cityList;

@property(nonatomic,strong)NSMutableArray *hotCityList;

@property(nonatomic,strong)NSArray *keys;

@end
