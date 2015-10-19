//
//  CallView.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "CallView.h"

@implementation CallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 80, 20)];
        [self addSubview:self.titleLabel];
        
        self.tellLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 10, 150, 20)];
        [self addSubview:self.tellLabel];
        
        self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.callBtn.frame = CGRectMake(self.frame.size.width - 60, 0, 60, 40);
        [self.callBtn setImage:[UIImage imageNamed:@"拨号"] forState:UIControlStateNormal];
        [self addSubview:self.callBtn];
        
    }
    return self;
}

@end
