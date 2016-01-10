//
//  CartTableViewCell.h
//  YMApp
//
//  Created by yannis on 16/1/7.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "CartModel.h"

@protocol CartTableViewCellDelegate <NSObject>

-(void)updateShopCart;

-(void)CheckButtonClick;

@end

@interface CartTableViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property(nonatomic,assign)Boolean isSelected;

@property(nonatomic,strong)Product *product;

@property(nonatomic,assign)NSInteger buyNumber;

@property(nonatomic,assign)id<CartTableViewCellDelegate> delegate;

@end
