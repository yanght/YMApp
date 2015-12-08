//
//  ListProductCell.m
//  YMApp
//
//  Created by yannis on 15/11/22.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "ListProductCell.h"
#import "UIImageView+WebCache.h"

@interface ListProductCell ()
{
    UIImageView *_imgview;
    UILabel *_nameLabel;
    UILabel *_currentPrice;
    UILabel *_oldPrice;
    UILabel *_Spec;
}

@end

@implementation ListProductCell
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubView];
    }
    
    return self;
}

#pragma 初始化子控件
-(void) initSubView
{
    _imgview=[[UIImageView alloc]initWithFrame:CGRectMake(25, 0, REAL_WIDTH1(150), REAL_WIDTH1(150))];
    _imgview.layer.borderColor=RGB(222, 222, 222).CGColor;
    _imgview.layer.borderWidth=0.5;
    _imgview.layer.cornerRadius=5;
    [self.contentView addSubview:_imgview ];
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.numberOfLines=0;
    [_nameLabel setFont:[UIFont systemFontOfSize:13]];
    [self.contentView addSubview:_nameLabel ];
    
    _currentPrice=[[UILabel alloc]init];
    _currentPrice.textColor=[UIColor redColor];
    [_currentPrice setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    
    [self.contentView addSubview:_currentPrice];
    
    _Spec=[[UILabel alloc]init];
    [_Spec setFont:[UIFont systemFontOfSize:10]];
    _Spec.textColor=GRAYCOLOR;
    [self.contentView addSubview:_Spec];
    
//    _oldPrice=[[UILabel alloc]init];
//    [_oldPrice setFont:[UIFont systemFontOfSize:13]];
//    _oldPrice.textColor=[UIColor grayColor];
//    [self.contentView addSubview:_oldPrice];
    
    
}

#pragma 加载子控件数据
-(void)setProduct:(Product *)product
{
#pragma 商品图片
    _imgview.frame=CGRectMake(REAL_WIDTH1(25), REAL_WIDTH1(25), REAL_WIDTH1(148), REAL_WIDTH1(148));
    //[_imgview  sd_setImageWithURL:[[NSURL alloc]initWithString:product.SmallPic ]];
    [_imgview sd_setImageWithURL:[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@",product.SmallPic]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
    _imgview.contentMode=UIViewContentModeScaleToFill;
    
    
#pragma 过时方法设置label文字自适应大小（自动换行）
    //    CGSize size = [product.CommodityName sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(screen_width-REAL_WIDTH1(45)-_imgview.frame.size.width-30,10000.0f)lineBreakMode:NSLineBreakByWordWrapping];
    //
    CGSize size = CGSizeMake(screen_width-REAL_WIDTH1(45)-_imgview.frame.size.width-30,10000.0f); //设置一个行高上限
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSDictionary *attribute = @{NSFontAttributeName: _nameLabel.font};
    
    CGSize namesize=[product.CommodityName boundingRectWithSize:size options:options attributes:attribute context:nil].size;
    
    CGFloat nameX=CGRectGetMaxX(_imgview.frame)+REAL_WIDTH1(20);
    CGFloat nameY=REAL_WIDTH1(25);
    CGRect nameRect=CGRectMake(nameX, nameY, namesize.width,namesize.height);
    _nameLabel.text=product.CommodityName;
    _nameLabel.frame=nameRect;
    
    CGSize sizeName = [@"¥ 200.0" sizeWithFont:[UIFont systemFontOfSize:16]
                          constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
                              lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect currentPriceRect=CGRectMake(nameX, REAL_WIDTH1(152), sizeName.width,REAL_WIDTH1(25));
    _currentPrice.frame=currentPriceRect;
    
#pragma 属性化当前价格
    NSString *currentprice=[NSString stringWithFormat:@"¥ %.1f",[product.CommodityPrice floatValue]];
    NSMutableAttributedString *attrs=[[NSMutableAttributedString alloc]initWithString:currentprice];
    NSInteger length=[currentprice length];
    UIFont *basefont=[UIFont systemFontOfSize:12];
    [attrs addAttribute:NSFontAttributeName value:basefont range:NSMakeRange(length-1, 1)];
    _currentPrice.attributedText=attrs;

    
#pragma 商品规格
    CGFloat specX=CGRectGetMaxX(_currentPrice.frame);
    CGFloat specY=REAL_WIDTH1(152);
    _Spec.frame=CGRectMake(specX, specY, REAL_WIDTH1(165), REAL_WIDTH1(25));
    _Spec.text=product.Spec;
    
}

#pragma 重绘Cell 添加顶部分割线
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context,RGB(222, 222, 222).CGColor);
    
    //    //下分割线
    //    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextStrokeRect(context, CGRectMake(0, self.frame.size.height, rect.size.width , 0.01));
}

@end
