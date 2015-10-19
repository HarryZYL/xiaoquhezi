//
//  BasicHeader.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "BasicHeader.h"

@implementation BasicHeader


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.headBackground];
        
        self.headImage = [[UIImageView alloc] init];
        self.headImage.frame = CGRectMake(0, 0, 80, 80);
        self.headImage.center = CGPointMake(self.frame.size.width/2, 50);
        [self addSubview:self.headImage];
        
        self.functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.functionBtn.frame =CGRectMake(0, 0, 80, 80);
        self.functionBtn.center = CGPointMake(self.frame.size.width/2, 50);
        [self addSubview:self.functionBtn];
        
        self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        self.userLabel.center = CGPointMake(self.frame.size.width/2, 110);
        self.userLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.userLabel];
        
        self.communityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        self.communityLabel.center = CGPointMake(self.frame.size.width/2, 140);
        self.communityLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.communityLabel];
        
    }
    return self;
}
@end
