//
//  RushTableViewCell.h
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBanner.h"
#import "HomeGroup.h"

@interface RushTableViewCell : UITableViewCell

@property(nonatomic,strong)HomeGroup *group;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier group:(HomeGroup *)group;

@end
