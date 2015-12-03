//
//  RushTableViewCell.m
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "RushTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface RushTableViewCell ()
{
    UILabel *_titleLabel;
}

@end

@implementation RushTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier group:(HomeGroup *)group
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;

         _titleLabel=[[UILabel alloc]init];
        [_titleLabel setText:group.GroupTitle];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [_titleLabel setFrame:CGRectMake(REAL_WIDTH1(20), 0, screen_width, REAL_WIDTH1(60))];
        [self.contentView addSubview:_titleLabel];
        
        
        for (int i=0; i<group.HomeBanners.count; i++) {
            HomeBanner *banner=[group.HomeBanners objectAtIndex:i];
            UIImageView *imgView=[[UIImageView alloc]init];
            imgView.frame=CGRectMake(REAL_WIDTH1(205)*i+REAL_WIDTH1(12), REAL_WIDTH1(60), REAL_WIDTH1(205), REAL_WIDTH1(254));
            [imgView sd_setImageWithURL:[[NSURL alloc] initWithString:banner.PictureUrl]];
            imgView.layer.borderColor=RGB(222, 222, 222).CGColor;
            imgView.layer.borderWidth=0.5;
 
            [imgView setTag:100+i];
            [self.contentView addSubview:imgView];
        }
    }
    return self;
}

-(void)setGroup:(HomeGroup *)group
{
    _titleLabel.text=group.GroupTitle;
    for (int i=0; i<group.HomeBanners.count; i++) {
        HomeBanner *banner=[group.HomeBanners objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc]viewWithTag:100+i];
        [imgView sd_setImageWithURL:[[NSURL alloc]initWithString:banner.PictureUrl]];
    }
   }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
