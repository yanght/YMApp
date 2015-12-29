//
//  ProductCommentCell.m
//  YMApp
//
//  Created by yannis on 15/12/27.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ProductCommentCell.h"

@implementation ProductCommentCell

-(void)setCommentCount:(NSInteger)count goodPercent:(CGFloat)percent
{
    if (count==0) {
        self.textLabel.text=[NSString stringWithFormat:@"用户评价"];
    }else
    {
        self.textLabel.text=[NSString stringWithFormat:@"用户评价(%ld)",(long)count];
    }
    self.textLabel.textColor=GRAYCOLOR;
    self.textLabel.font=[UIFont systemFontOfSize:14];
    self.detailTextLabel.text=[NSString stringWithFormat:@"%ld%%好评",(long)percent];
    self.detailTextLabel.font=[UIFont systemFontOfSize:14];
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.height=self.frame.size.height;

    NSInteger length=[self.detailTextLabel.text length];
    NSMutableAttributedString *attrs=[self.detailTextLabel.text AttributedStringWithFont:nil withColor:RGB(253, 54, 75)  range:NSMakeRange(0,length-2)];
    self.detailTextLabel.attributedText=attrs;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
