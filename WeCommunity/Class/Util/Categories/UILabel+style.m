//
//  UILabel+style.m
//  WeCommunity
//
//  Created by Harry on 9/15/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "UILabel+style.h"

@implementation UILabel (style)

-(void)grayColorStyle:(CGFloat)fontSize{
    self.textColor = [UIColor grayColor];
    self.font = [UIFont fontWithName:fontName size:fontSize];
}

@end
