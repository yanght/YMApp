//
//  RushTableViewCell.m
//  YMApp
//
//  Created by yannis on 15/12/2.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "RushTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "YmGestureRecognizer.h"

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
            
            [imgView setTag:1000+i];
            [self.contentView addSubview:imgView];
            
            YmGestureRecognizer*tap=[[YmGestureRecognizer alloc]initWithTarget:self action:@selector(didTapView:)];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:banner.LinkCode forKey:@"LinkCode"];
            [dic setObject:banner.LinkType forKey:@"LinkType"];
            [dic setObject:banner.LinkUrl forKey:@"LinkUrl"];
            tap.parm=dic;
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:tap];

        }
    }
    return self;
}

-(void)setGroup:(HomeGroup *)group
{
    _group=group;
    _titleLabel.text=group.GroupTitle;
    for (int i=0; i<group.HomeBanners.count; i++) {
        HomeBanner *banner=[group.HomeBanners objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc]viewWithTag:1000+i];
        [imgView sd_setImageWithURL:[[NSURL alloc]initWithString:banner.PictureUrl]];
    }
}

-(void)didTapView:(YmGestureRecognizer *)sender
{
    NSMutableDictionary *dic=sender.parm;
    
    NSString *linkCode=[dic objectForKey:@"LinkCode"];
    NSInteger linkType=[[dic objectForKey:@"LinkType"] integerValue];
    NSString *linkUrl=[dic objectForKey:@"LinkUrl"];
    
    if (linkType==1) {
        [self.delegate didSelectProduct:linkCode];
    }else if (linkType==3)
    {
        [self.delegate didSelectActivity:linkUrl];
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
