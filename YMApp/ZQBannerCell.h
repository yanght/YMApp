//
//  ZQBannerCell.h
//  YMApp
//
//  Created by yannis on 15/11/3.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeGroup.h"

@interface ZQBannerCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier group:(HomeGroup *)group;

@property(nonatomic,strong)HomeGroup *group;

@property(nonatomic,assign)id<ProductTapProtocol> delegate;

@end
