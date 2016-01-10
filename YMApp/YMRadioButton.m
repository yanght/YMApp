//
//  YMRadioButton.m
//  YMApp
//
//  Created by yannis on 16/1/8.
//  Copyright © 2016年 yannis. All rights reserved.
//

#import "YMRadioButton.h"

@interface YMRadioButton ()
{
    
    UIImage *_unCheckImage;
    UIImage *_checkImage;
}

@end

@implementation YMRadioButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.Checked=TRUE;
        _unCheckImage=[UIImage imageNamed:@"check"];
        [self setImage:_unCheckImage forState:UIControlStateNormal];
        [self addTarget:self action:@selector(checked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)checked:(id)sender
{
    if (self.Checked) {
        _unCheckImage=[UIImage imageNamed:@"uncheck"];
        [self setImage:_unCheckImage forState:UIControlStateNormal];
    }else
    {
        _checkImage=[UIImage imageNamed:@"check"];
        [self setImage:_checkImage forState:UIControlStateNormal];
    }
    self.Checked=!self.Checked;
}
@end
