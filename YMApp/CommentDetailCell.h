//
//  CommentDetailCell.h
//  YMApp
//
//  Created by yannis on 16/1/3.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductComment.h"

@interface CommentDetailCell : UITableViewCell

@property(nonatomic,assign)CGFloat height;

@property(nonatomic,strong) UILabel *nameLabel;

@property(nonatomic,strong) UILabel *dateLabel;

@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong)ProductComment *comment;

@end
