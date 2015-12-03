//
//  CategoryTableViewCell.m
//  YMApp
//
//  Created by yannis on 15/11/28.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "MCategory.h"

@interface CategoryTableViewCell ()
{
    UIImageView *imgview;
    UILabel *categoryName;
    UILabel *subCategorys;
}

@end

@implementation CategoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    imgview=[[UIImageView alloc]init];
    [self.contentView addSubview:imgview];
    
    categoryName=[[UILabel alloc]init];
    categoryName.numberOfLines=1;
    [self.contentView addSubview:categoryName];
   
    subCategorys=[[UILabel alloc]init];
    subCategorys.textColor=GRAYCOLOR;
    subCategorys.numberOfLines=1;
    [self.contentView addSubview:subCategorys];
}
-(void)setCategory:(MCategory *)category
{
    CGFloat paddingTop=(REAL_WIDTH1(160)-REAL_WIDTH1(92))/2;
    
    imgview.image=[UIImage imageNamed:category.categoryImg];
    imgview.frame=CGRectMake(20,paddingTop, REAL_WIDTH1(92), REAL_WIDTH1(92));
    
    CGSize namesize=[category.categoryName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    CGRect nameframe=CGRectMake(CGRectGetMaxX(imgview.frame)+20, CGRectGetMinY(imgview.frame), screen_width-imgview.bounds.size.width, namesize.height);
    categoryName.frame=nameframe;
    categoryName.text=category.categoryName;
    
    
    subCategorys.text=category.sunCategorys;
    subCategorys.frame=CGRectMake(CGRectGetMaxX(imgview.frame)+20, CGRectGetMaxY(categoryName.frame)-10, screen_width-imgview.bounds.size.width, REAL_WIDTH1(160)-CGRectGetMaxY(categoryName.frame));
    [subCategorys setFont:[UIFont systemFontOfSize:13]];
    subCategorys.text=category.descrip;
}

#pragma 重绘Cell 添加顶部分割线
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context,GRAYCOLOR.CGColor);
    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width , 0.01));
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
