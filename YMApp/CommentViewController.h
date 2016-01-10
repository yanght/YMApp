//
//  CommentViewController.h
//  YMApp
//
//  Created by yannis on 16/1/3.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSString *commodityId;

@property(nonatomic,assign)NSInteger pageIndex;

@property(nonatomic,strong)NSMutableArray *comments;

@property(nonatomic,strong)UITableView *tableView;

@end
