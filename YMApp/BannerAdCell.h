//
//  BannerAdCell.h
//  YMApp
//
//  Created by yannis on 15/11/5.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeGroup.h"

@interface BannerAdCell : UITableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier group:(HomeGroup *)group;

@property (assign,nonatomic) CGFloat height;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)HomeGroup *group;

@end
