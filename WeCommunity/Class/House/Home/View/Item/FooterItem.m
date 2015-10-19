//
//  FooterItem.m
//  WeCommunity
//
//  Created by Harry on 7/21/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "FooterItem.h"

@implementation FooterItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.footerBtn.frame = CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30);
        self.footerBtn.center = CGPointMake(0.35*self.frame.size.width, 0.5*self.frame.size.height);
        [self.footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.footerBtn];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 20)];
        self.titleLabel.center = CGPointMake(0.65*self.frame.size.width, 0.5*self.frame.size.height);
        self.titleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

@end
