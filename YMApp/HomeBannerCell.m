//
//  HomeBannerCell.m
//  YMApp
//
//  Created by yannis on 15/11/2.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "HomeBannerCell.h"
#import "SDCycleScrollView.h"

@interface HomeBannerCell()<SDCycleScrollViewDelegate>
{
  SDCycleScrollView *_cycleScrollView2;
}

@end

@implementation HomeBannerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
       _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) imageURLStringsGroup:nil]; // 模拟网络延时情景
        _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView2.delegate = self;
       // cycleScrollView2.titlesGroup = titles;
        _cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;

        _cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
        [self.contentView addSubview:_cycleScrollView2];
    }
    return self;
}

-(void)setImages:(NSArray *)images
{
   _cycleScrollView2.imageURLStringsGroup = images;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}



@end
