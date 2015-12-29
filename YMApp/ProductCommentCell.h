//
//  ProductCommentCell.h
//  YMApp
//
//  Created by yannis on 15/12/27.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseProductCell.h"

@interface ProductCommentCell : BaseProductCell
-(void)setCommentCount:(NSInteger)count goodPercent:(CGFloat)percent;
@end
