//
//  LoadingView.m
//  WeCommunity
//
//  Created by Harry on 8/6/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
//        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
        
        self.backgroungImg = [[UIImageView alloc] init];
        self.backgroungImg.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
        self.backgroungImg.layer.masksToBounds = YES;
        self.backgroungImg.layer.cornerRadius = 10;
        [self addSubview:self.backgroungImg];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.backgroungImg addSubview:self.titleLabel];
        
        self.actView = [[UIActivityIndicatorView alloc] init];
        self.actView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        self.actView.hidesWhenStopped=NO;
        [self.actView startAnimating];
        [self.backgroungImg addSubview:self.actView];
    }
    return self;
}

-(void)layoutSubviews{
    
    self.backgroungImg.frame = CGRectMake(0, 0, 120, 100);
    self.backgroungImg.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2.5);
    self.actView.frame = CGRectMake(0, 0, 40, 40);
    self.actView.center = CGPointMake(self.backgroungImg.frame.size.width/2, 40);
    
    self.titleLabel.frame = CGRectMake(0, 60, self.backgroungImg.frame.size.width, 30);
    
}

@end
