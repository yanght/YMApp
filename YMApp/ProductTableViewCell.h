//
//  ProductTableViewCell.h
//  YMApp
//
//  Created by yannis on 15/12/23.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewModel.h"

@interface ProductTableViewCell : UITableViewCell

@property(nonatomic,strong)ProductViewModel *productViewModel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  productViewModel:(ProductViewModel *)productViewModel;

@end
