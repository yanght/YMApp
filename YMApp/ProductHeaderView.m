//
//  ProductHeaderView.m
//  YMApp
//
//  Created by yannis on 15/12/27.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductHeaderView.h"

@implementation ProductHeaderView

-(void)setImages:(NSArray *)images{
    SDCycleScrollView *_cycleScrollView2=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) imageURLStringsGroup:images] ;
    _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _cycleScrollView2.backgroundColor=[UIColor whiteColor];
    _cycleScrollView2.autoScroll=false;
    [self addSubview:_cycleScrollView2];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
