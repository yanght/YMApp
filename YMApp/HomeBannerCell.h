//
//  HomeBannerCell.h
//  YMApp
//
//  Created by yannis on 15/11/2.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBanner.h"

@protocol HomeBannerDelegate <NSObject>

-(void)didSelectBannerUrl:(HomeBanner *)banner atIndex:(NSInteger)index;

@end

@interface HomeBannerCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;

@property(nonatomic,strong)NSArray *banners;

@property(nonatomic,assign)id<HomeBannerDelegate> delegate;

@end
