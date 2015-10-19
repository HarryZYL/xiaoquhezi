//
//  SecondHandPostView.m
//  WeCommunity
//
//  Created by Harry on 8/16/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SecondHandPostView.h"

@implementation SecondHandPostView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        标题
        CGFloat textHeight = 45;
        self.titleField = [[UITextField alloc] init];
        self.titleField.frame = CGRectMake(10, 0, frame.size.width-20, textHeight);
        self.titleField.placeholder = @"标题";
        [self addSubview:self.titleField];
        
        GrayLine *firstLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, textHeight, frame.size.width, 1)];
        [self addSubview:firstLine];
//        原价
        self.originalPriceField = [[UITextField alloc] init];
        self.originalPriceField.frame = CGRectMake(10, textHeight, (frame.size.width-20)/2, textHeight);
        self.originalPriceField.placeholder = @"原价";
        [self addSubview:self.originalPriceField];
//        交易价
        self.dealPriceField = [[UITextField alloc] init];
        self.dealPriceField.frame = CGRectMake(10+(frame.size.width-20)/2, textHeight, (frame.size.width-20)/2, textHeight);
        self.dealPriceField.placeholder = @"交易价";
        [self addSubview:self.dealPriceField];
        
        GrayLine *secondLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, 2*textHeight, frame.size.width, 1)];
        [self addSubview:secondLine];
//        描述
        self.describleView=[[SAMTextView alloc] initWithFrame:CGRectMake(10,secondLine.frame.origin.y+10, frame.size.width-20, 100)];
        self.describleView.placeholder=@"描述";
        self.describleView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
        self.describleView.font=[UIFont fontWithName:@"Arial" size:15];
        [self addSubview:self.describleView];
        
        self.cameraView = [[CameraImageView alloc] initWithFrame:CGRectMake(10, self.describleView.frame.size.height+self.describleView.frame.origin.y+10, frame.size.width-20, 150)];
        [self addSubview:self.cameraView];

    }
    return self;
}

@end
