//
//  GrayLine.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "GrayLine.h"

@implementation GrayLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-10, frame.size.height)];
        [self addSubview:self.titleLabel];
        
    }
   return self;
}

@end
