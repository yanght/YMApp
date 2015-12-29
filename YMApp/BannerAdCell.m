//
//  BannerAdCell.m
//  YMApp
//
//  Created by yannis on 15/11/5.
//  Copyright (c) 2015年 yannis. All rights reserved.
//

#import "BannerAdCell.h"
#import "HomeGroup.h"
#import "HomeBanner.h"
#import "UIImageView+WebCache.h"

@interface BannerAdCell ()
{
    UILabel *_titleLabel;
}

@end

@implementation BannerAdCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier group:(HomeGroup *)group
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        _titleLabel=[[UILabel alloc]init];
        [_titleLabel setText:self.title];
        _titleLabel.numberOfLines=0;
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
       
        CGSize sizetitle = [self.title sizeWithFont:[UIFont systemFontOfSize:13]
                                 constrainedToSize:CGSizeMake(screen_width, 1000.0)
                                     lineBreakMode:NSLineBreakByWordWrapping];
        
        [_titleLabel setFrame:CGRectMake(REAL_WIDTH1(20), 0, screen_width, REAL_WIDTH1(60))];
        [self.contentView addSubview:_titleLabel];
    
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        for (int i=0; i<group.HomeBanners.count; i++) {
            HomeBanner *banner= [group.HomeBanners objectAtIndex:i];
            if (![banner.LinkCode isEqualToString:@""]) {
                
            CGRect frame=CGRectMake(REAL_WIDTH1(12),REAL_WIDTH1(60)+ REAL_WIDTH1(240+10)*i, [UIScreen mainScreen].bounds.size.width-REAL_WIDTH1(24), REAL_WIDTH1(240));
            UIImageView *imgview= [[UIImageView alloc]init];
            imgview.userInteractionEnabled=YES;
                
            [imgview.layer setBorderWidth:0.5];
            [imgview.layer setBorderColor:RGB(222, 222, 222).CGColor];
            imgview.frame=frame;
            [imgview setTag:200+i];
           // imgview.image=[UIImage imageNamed:banner.PictureUrl];
            [imgview sd_setImageWithURL:[[NSURL alloc]initWithString:banner.PictureUrl]];
            [self.contentView addSubview:imgview];
                
                        YmGestureRecognizer *tap=[[YmGestureRecognizer alloc]initWithTarget:self action:@selector(didTapView:)];
                NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                [dic setObject:banner.LinkCode forKey:@"LinkCode"];
                [dic setObject:banner.LinkType forKey:@"LinkType"];
                [dic setObject:banner.LinkUrl forKey:@"LinkUrl"];
                tap.parm=dic;
                imgview.userInteractionEnabled=YES;
                [imgview addGestureRecognizer:tap];

            }
        }
      }
    return self;
}

-(void)setGroup:(HomeGroup *)group {
    _group=group;
    _titleLabel.text=self.title;
    for (int i=0; i<group.HomeBanners.count; i++) {
        HomeBanner *banner=[group.HomeBanners objectAtIndex:i];
        if (![banner.LinkCode isEqualToString:@""]) {            
        UIImageView *imgview=[[UIImageView alloc]viewWithTag:200+i];
        [imgview sd_setImageWithURL:[[NSURL alloc]initWithString:banner.PictureUrl]];
        self.height+=(REAL_WIDTH1(240+10));
        }
    }
    self.height+=_titleLabel.frame.size.height;
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

@end
