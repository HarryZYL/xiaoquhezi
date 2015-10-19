//
//  HouseFooterView.m
//  WeCommunity
//
//  Created by Harry on 7/20/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HouseFooterView.h"

@implementation HouseFooterView

- (id)initWithFrame:(CGRect)frame
 {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat itemHeight = 85;
        CGFloat leftMargin = 20;
        CGFloat itemMargin = 15;
        CGFloat itemWidth = frame.size.width/2 - leftMargin - itemMargin/2 ;
        
        self.firstItem = [[FooterItem alloc] initWithFrame:CGRectMake(leftMargin, 0, itemWidth, itemHeight)];
        self.firstItem.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:230.0/255.0 blue:227.0/255.0 alpha:1];
        [self.firstItem.footerBtn setImage:[UIImage imageNamed:@"表扬"] forState:UIControlStateNormal];
        self.firstItem.titleLabel.text = @"表扬";
        [self addSubview:self.firstItem];
        
        self.secondItem = [[FooterItem alloc] initWithFrame:CGRectMake(leftMargin + itemWidth + itemMargin, 0, itemWidth, itemHeight)];
        [self.secondItem.footerBtn setImage:[UIImage imageNamed:@"投诉"] forState:UIControlStateNormal];
        self.secondItem.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:246.0/255.0 blue:241.0/255.0 alpha:1];
        self.secondItem.titleLabel.text = @"投诉";
        [self addSubview:self.secondItem];
//        
//        self.thirdItem = [[FooterItem alloc] initWithFrame:CGRectMake(leftMargin + 2*(itemMargin +itemWidth), 0, itemWidth, itemHeight)];
//        [self.thirdItem.footerBtn setImage:[UIImage imageNamed:@"community"] forState:UIControlStateNormal];
//        self.thirdItem.titleLabel.text = @"小区一览";
//        [self addSubview:self.thirdItem];
        
    }
    return self;
 }

@end
