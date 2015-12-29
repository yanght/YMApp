//
//  Utils.h
//  YMApp
//
//  Created by yannis on 15/12/4.
//  Copyright © 2015年 yannis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Utils : NSObject

+(MBProgressHUD *)createHUD;

+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;

@end
