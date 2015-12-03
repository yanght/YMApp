//
//  HomeBannerCell.h
//  YMApp
//
//  Created by yannis on 15/11/2.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBannerCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;

@property(nonatomic,strong)NSArray *images;

@end
