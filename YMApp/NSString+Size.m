//
//  NSString+Size.m
//  meituan
//
//  Created by jinzelu on 15/7/21.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)boundingRectWithSize:(CGSize)size withFont:(NSInteger)font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    
    CGSize retSize = [self boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
-(NSMutableAttributedString *) AttributedStringWithFont:(UIFont *)font withColor:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *attrs=[[NSMutableAttributedString alloc]initWithString:self];
    if (font!=nil) {
        [attrs addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color!=nil) {
         [attrs addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return attrs;
}
@end
