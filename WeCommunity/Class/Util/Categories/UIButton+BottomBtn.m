//
//  BottomBtn.m
//  WeCommunity
//
//  Created by Harry on 7/29/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "UIButton+BottomBtn.h"


@implementation UIButton (BottomBtn)

-(void)configureButtonTitle:(NSString *)title backgroundColor:(UIColor *)color{
     self.backgroundColor = color;
    [self setTintColor:[UIColor whiteColor]];
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:fontName size:16];
}

-(void)leftStyle{

    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self setTintColor:[UIColor grayColor]];
    self.titleLabel.font = [UIFont fontWithName:fontName size:18];

}

-(void)roundRect{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}



@end
