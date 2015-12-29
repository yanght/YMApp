//
//  MemberTableViewCell.m
//  YMApp
//
//  Created by yannis on 15/12/21.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "MemberTableViewCell.h"
#import "BannerButton.h"

@implementation MemberTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userImgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, REAL_WIDTH1(330))];
        self.userImgView.backgroundColor=RGB(230, 246, 239);
        [self.contentView addSubview:self.userImgView];
        
        
        UIImageView *userImg=[[UIImageView alloc]init];
        [userImg setImage:[UIImage imageNamed:@"01.jpg"]];
        userImg.layer.masksToBounds = YES;
        userImg.layer.cornerRadius=REAL_WIDTH1(190/2);
        [userImg setFrame:CGRectMake((screen_width-REAL_WIDTH1(190))/2, REAL_WIDTH1(330-190)/3, REAL_WIDTH1(190), REAL_WIDTH1(190))];
        [userImg setBackgroundColor:[UIColor redColor]];
        [self.userImgView addSubview:userImg];
        
        
        self.pointView=[[UIView alloc]init];
        [self.pointView setFrame:CGRectMake(0, CGRectGetMaxY(self.userImgView.frame), screen_width, REAL_WIDTH1(90))];
        self.pointView.backgroundColor=[UIColor greenColor];
        [self.contentView addSubview:self.pointView];
        
        UILabel *ubLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,0, screen_width/2, self.pointView.frame.size.height)];
        [ubLabel setText:@"121"];
        ubLabel.textAlignment=NSTextAlignmentCenter;
        
        [self.pointView addSubview:ubLabel];
        
        UILabel *accountLabel=[[UILabel alloc]init];
        [accountLabel setFrame:CGRectMake(CGRectGetMaxX(ubLabel.frame), 0, screen_width/2, REAL_WIDTH1(90))];
        [accountLabel setText:@"21212"];
        accountLabel.textAlignment=NSTextAlignmentCenter;
        [self.pointView addSubview:accountLabel];
        
        UILabel *spliteLabel=[[UILabel alloc]init];
        [spliteLabel setFrame:CGRectMake(CGRectGetMaxX(ubLabel.frame), REAL_WIDTH1(20), 2, REAL_WIDTH1(50))];
        [spliteLabel setBackgroundColor:GRAYCOLOR];
        [self.pointView addSubview:spliteLabel];
        
        self.iconPannel=[[UIView alloc]init];
        [self.iconPannel setBackgroundColor:RGB(250, 253, 253)];
        [self.contentView addSubview:self.iconPannel];
        [self.iconPannel setFrame:CGRectMake(0, CGRectGetMaxY(self.pointView.frame), screen_width/3, REAL_WIDTH1(400))];

        
        NSArray *iconName=@[@"user_icon01",@"user_icon02",@"user_icon03",@"user_icon04"];
        NSArray *iconTitle=@[@"我的订单",@"优惠券",@"卡券充值",@"收货地址"];
        
        for (int i=0; i<iconName.count; i++) {
//            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((screen_width/3)*i, 0, screen_width/3, REAL_WIDTH1(125))];
//            button.layer.borderColor=[UIColor redColor].CGColor;
//            button.layer.borderWidth=0.5;
//            UIImage *img=[UIImage imageNamed:[iconName objectAtIndex:i]];
//            NSString *title=[iconTitle objectAtIndex:i];
//            [button setImage:img forState:UIControlStateNormal];
//            [button setImageEdgeInsets:UIEdgeInsetsMake(0, (button.bounds.size.width-REAL_WIDTH1(77))/2, 0, 0)];
//            
//            [button setTitle:title forState:UIControlStateNormal];
//            [button setTitleEdgeInsets:UIEdgeInsetsMake(H(button.imageView), 0, 0, 0)];

            UIView *buttonView=[[UIView alloc]init];
            
            [self.iconPannel addSubview:buttonView];
        }
}
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
