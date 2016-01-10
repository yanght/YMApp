//
//  CommentDetailCell.m
//  YMApp
//
//  Created by yannis on 16/1/3.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "CommentDetailCell.h"
#define PaddingLeft REAL_WIDTH1(30)
#define PaddingTop 10;

@implementation CommentDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLabel=[[UILabel alloc]init];
        self.nameLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        
        self.dateLabel=[[UILabel alloc]init];
        self.dateLabel.textColor=GRAYCOLOR;
        self.dateLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.dateLabel];
        
        self.contentLabel=[[UILabel alloc]init];
        self.contentLabel.textColor=GRAYCOLOR;
        self.contentLabel.numberOfLines=0;
        self.contentLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.contentLabel];
        
        
    }
    return self;
}

-(void)setComment:(ProductComment *)comment
{
    self.nameLabel.text=comment.UserName;
    self.nameLabel.frame=CGRectMake(PaddingLeft, 0, REAL_WIDTH1(150), REAL_WIDTH1(40));
    
    self.dateLabel.frame=CGRectMake(screen_width-REAL_WIDTH1(270), 0, REAL_WIDTH1(270), REAL_WIDTH1(40));
    self.dateLabel.text=comment.VoteDate;
    
    CGSize conmectSize=[comment.CommentContent  boundingRectWithSize:CGSizeMake(screen_width-PaddingLeft*2, MAXFLOAT) withFont:15];
    
    self.contentLabel.frame=CGRectMake(PaddingLeft, CGRectGetMaxY(self.nameLabel.frame), conmectSize.width, conmectSize.height);
    self.contentLabel.text=comment.CommentContent;
    
    
    
    self.height=20+self.nameLabel.frame.size.height+self.contentLabel.frame.size.height;
    
}

@end
